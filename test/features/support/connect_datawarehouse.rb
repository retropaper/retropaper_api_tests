# require 'pg'


class Connect_Datawarehouse

    def self.connect_to_datawarehouse_db
        begin
            @conn_warehouse = PG::Connection.new(:host => ENV['HOSTNAME_DB_DW'], :port => ENV['PORT_DB_DW'], :dbname => ENV['DB_NAME_DB_DW'], :user => ENV['USER_DB_DW'], :password => ENV['PASS_DB_DW'])

        rescue PGconn::Error => e
            @conn_warehouse = e.message
        end
    end

    def Connect_Datawarehouse.datawarehouse_query query
        connect_pa_db = connect_to_datawarehouse_db
        query_string = "#{query}"
        connect_pa_db.exec(query_string)
    end

end
