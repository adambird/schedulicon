# Public: Describes a schedule in a portable fashion
#
require 'time'
require 'date'

module Schedulicon
  class Schedule
    FREQUENCIES = {
      :every => 0,
      :first => 1,
      :second => 2,
      :third => 3,
      :fourth => 4,
      :last => -1
    }

    attr_accessor :frequency, :day_of_week, :start_at, :end_on

    # Public: Hash of attributes that can be used to deserialise item from
    #
    def to_hash
      hash = {
        'frequency' => frequency,
        'start_at' => start_at.xmlschema,
        'day_of_week' => day_of_week
      }
      hash['end_on'] = end_on.xmlschema if end_on
      hash
    end

    # Public: load schedule from the hash
    #
    def self.load(attrs)
      schedule = Schedule.new
      schedule.start_at = Time.xmlschema(attrs['start_at']).localtime
      schedule.end_on = Time.xmlschema(attrs['end_on']).localtime if attrs['end_on']
      schedule.day_of_week = attrs['day_of_week'].to_i
      schedule.frequency = attrs['frequency'].to_sym
      schedule
    end

    # Public: generates the expression required to generate the schedule dates
    #
    def expression
      case frequency
      when :every
        DayOfWeek.new(day_of_week)
      else
        DayInMonth.new(day_of_week, FREQUENCIES[frequency])
      end
    end

    # Public: generate a list of dates for the schedule
    #
    def dates(from=nil, to=nil)
      from ||= start_at
      to ||= (end_on || from.to_date >> 12)
      expression.dates(from, to)
    end
  end
end