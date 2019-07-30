# require 'pg'
require_relative 'bdd_logger'
#require_relative '../env_authorization_key'

class PgHelper
  def initialize(bd_abbreviation, single_query=true)
    @single_query = single_query
    unless bd_abbreviation.nil?
      begin
        @connection = PG.connect(conn_info(bd_abbreviation))
      rescue PG::Error => e
        BddLogger.error(e.message)
      ensure
      end
    end
  end

  def conn_info(bd_abbreviation)
    {
        :host => ENV["TEST_DB_HOST_#{bd_abbreviation}"],
        :port => ENV["TEST_DB_PORT_#{bd_abbreviation}"].to_i,
        :dbname => ENV["TEST_DB_NAME_#{bd_abbreviation}"],
        :user => ENV["TEST_DB_USERNAME_#{bd_abbreviation}"],
        :password => ENV["TEST_DB_PASSWORD_#{bd_abbreviation}"]
    }
  end

  def connect(host, port, dbname, user, password)
    begin
      @connection = PG.connect :host => host, :port => port, :dbname => dbname, :user => user, :password => password
    rescue PG::Error => e
      BddLogger.error(e.message)
    ensure
    end
  end

  def execute(sql)
    begin
      rs = @connection.exec(sql)
    rescue PG::Error => e
      BddLogger.error(e.message)
      raise e.message
    end
    close if @single_query
    rs.to_a unless rs.nil?
  end

  def tables
    sql = "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'"
    schema = execute(sql)
    schema.collect {|s| s['table_name']}
  end

  def columns(table_name)
    sql = "SELECT column_name, data_type FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='#{table_name}'"
    schema = execute(sql)
    result = {}
    schema.each {|c_d| result[c_d['column_name']] = c_d['data_type']}
    result
  end

  def scan(table_name, params={}, columns=[])
    col = columns.size > 0 ? columns.join(',') : '*'
    sql = "SELECT #{col} FROM #{table_name}"
    if params.size > 0
      query = []
      params.each do |k, v|
        if !v.present?
          query << "#{k} = null"
        elsif v.kind_of?(Array)
          query << "#{k} in (#{v.map { |s| "'#{s}'" }.join(', ')})"
        else
          query << "#{k}='#{v}'"
        end

      end
      sql += " WHERE #{query.join(' AND ')}"
    end
     # BddLogger.info("Executing SQL:\n#{sql}")
    execute(sql)
  end

  def random_records(table_name, limit=1, columns=[])
    col = columns.size > 0 ? columns.join(',') : '*'
    sql = "SELECT #{col} FROM #{table_name} ORDER BY RANDOM() LIMIT #{limit}"
    execute(sql)
  end

  def single_column_values(table_name, column, order_asc=true)
    sql = "select #{column} from #{table_name} order by #{column} "
    sql += order_asc ? 'asc' : 'desc'
    response = execute(sql)
    response.collect {|r| r[column]}
  end

  def set_value(table_name, value_hash, criteria_hash)
    sql = "UPDATE #{table_name} SET "
    values = []
    criteria = []
    value_hash.each {|k, v| values << "#{k}='#{v}'"}
    criteria_hash.each {|k, v| criteria << "#{k}='#{v}'"}
    sql += "#{values.join(', ')} WHERE #{criteria.join(' AND ')}"
    execute(sql)
  end

  def insert_value(table_name, columns=[],values=[])
    if columns.size != values.size
      flunk "Number of columns and Values does not match"
    end
    sql = "INSERT INTO #{table_name} "
    col = columns.join(',')
    val = values.join(',')
    sql += "(#{col}) VALUES (#{val})"
    execute(sql)
  end

  def close
    @connection.close
  end
end





