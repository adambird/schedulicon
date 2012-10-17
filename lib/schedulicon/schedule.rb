# Public: Describes a schedule in a portable fashion
#
require 'time'
require 'date'

module Schedulicon
  class Schedule
    FREQUENCIES = [:every, :first, :second, :third, :fourth, :last]

    attr_accessor :frequency, :day_of_week, :start_at, :end_on

    def initialize(attrs={})
      @start_at = Time.xmlschema(attrs['start_at']).localtime if attrs['start_at']
      @end_on = Time.xmlschema(attrs['end_on']).localtime if attrs['end_on']
      @day_of_week = attrs['day_of_week'] ? attrs['day_of_week'].to_i : Schedulicon::MONDAY
      @frequency = attrs['frequency'] ? attrs['frequency'].to_sym : :every
    end

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

    def attributes
      to_hash
    end

    # Public: load schedule from the hash
    #
    def self.load(attrs)
      Schedule.new(attrs)
    end

    # Public: generates the expression required to generate the schedule dates
    #
    def expression
      case frequency
      when :every
        DayOfWeek.new(day_of_week)
      else
        DayInMonth.new(day_of_week, frequency)
      end
    end

    # Public: generate a list of dates for the schedule
    #
    def dates(from=nil, to=nil)
      from ||= start_at
      to ||= ((end_on && end_on.to_date) || from.to_date >> 12)
      expression.dates(from, to).collect {|date| date.to_time }
    end

    # Public: override equality operator to compare values
    #
    def ==(other)
      return false unless other
      return false unless other.respond_to?(:frequency) && other.frequency == frequency
      return false unless other.respond_to?(:day_of_week) && other.day_of_week == day_of_week
      return false unless time_attribute_equal(other, :start_at)
      return false unless time_attribute_equal(other, :end_on)
      true
    end

    def time_attribute_equal(other, name)
      return false unless other.respond_to? name
      return other.send(name).utc == self.send(name).utc if other.send(name) && self.send(name)
      true
    end
  end
end