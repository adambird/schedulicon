module Schedulicon
  require 'schedulicon/version'
  require 'schedulicon/day_of_week'
  require 'schedulicon/day_in_month'
  
  # Days of the week
  MONDAY = 1
  TUESDAY = 2
  WEDNESDAY = 3
  THURSDAY = 4
  FRIDAY = 5
  SATURDAY = 6
  SUNDAY = 7
  
  # Public: generate an Array of dates for a given Schedule expression between
  # two dates
  # 
  # start_at    - DateTime range starts
  # end_on      - DateTime range ends
  # expression  - ScheduleExpression to use
  # 
  # Returns Array of DateTimes
  def generate(start_at, end_on, expression)
    expression.dates(start_at, end_on)
  end
end