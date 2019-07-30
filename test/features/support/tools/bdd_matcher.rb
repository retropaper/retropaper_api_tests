require_relative 'bdd_logger'

class BddMatcher
  @log_pass = false

  def self.log_pass_result(log = true)
    @log_pass = log
  end

  def self.eq(actual, expect, topic)
    match(actual, expect, 'equal to', topic)
  end

  def self.gt(actual, expect, topic)
    match(actual, expect, 'is greater than', topic)
  end

  def self.lt(actual, expect, topic)
    match(actual, expect, 'is less than', topic)
  end

  def self.include(actual, expect, topic)
    match(actual, expect, 'include', topic)
  end

  #reverse way of include
  def self.between(actual_value, expect_min, expect_max, topic)
    puts "\n"
    if actual_value.between?(expect_min, expect_max)
      if @log_pass
        BddLogger.info("Verifying \"#{topic}\"")
        BddLogger.info("Expect range is from #{expect_min.to_s} to #{expect_max}")
        BddLogger.info("Actual value is #{actual_value.to_s}")
        BddLogger.info('Actual value is between expect values, Pass!')
      end
    else
      v = "Verifying \"#{topic}\""
      e = "Expect range is from #{expect_min.to_s} to #{expect_max}"
      a = "Actual value is #{actual_value.to_s}"
      BddLogger.info(v)
      BddLogger.info(e)
       BddLogger.info(a)
      error = 'Actual value is out of expect range, Fail!'
      BddLogger.error error
      fail "#{v} | #{e} | #{a} | #{error}"
    end
  end

  def self.array_match(actual_array, expect_array, topic)
    print_header(actual_array, expect_array, topic)
    missing = expect_array - actual_array
    excess = actual_array - expect_array
    missing_error = "Missing: #{missing}"
    excess_error = "Excess: #{excess},   Fail!"
    if excess.size + missing.size > 0
      BddLogger.error missing_error
      BddLogger.error excess_error
      fail "#{missing_error} | #{excess_error}"
    else
      BddLogger.info('Actual array match expect array, Pass!')
    end
  end


  private_class_method def self.match(actual, expect, op_name, topic)
                         case (op_name)
                           when 'equal to' then
                             result = actual == expect
                           when 'is greater than' then
                             result = actual > expect
                           when 'is less than' then
                             result = actual < expect
                           when 'include' then
                             result = actual.include?(expect)
                           when 'between' then

                             result = actual.between?(expect[0], expect[1])
                           else
                             result = actual == expect
                         end
                         if result
                           if @log_pass
                             print_header(actual, expect, topic)
                             BddLogger.info("Actual value #{op_name} expect value, Pass!")
                           end
                         else
                           content = print_header(actual, expect, topic)
                           error = "Actual value should #{op_name} expect value, Fail!"
                           BddLogger.error error
                           fail "#{content} | #{error}"
                         end

                       end

  private_class_method def self.print_header(actual, expect, topic)
                         puts "\n"
                         v = "Verifying \"#{topic}\""
                         e = "Expect value is #{expect.to_s}"
                         a = "Actual value is #{actual.to_s}"
                         BddLogger.info(v)
                         BddLogger.info(e)
                         BddLogger.info(a)
                         "#{v}\n#{e}\n#{a}"
                       end
end