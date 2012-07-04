# Public: Represents a day in month expression
#
# examples
#
# DayInMonth.new(Schedulicon::THURSDAY, 2)  # second Thursday
# DayInMonth.new(Schedulicon::SATURDAY, -1)  # last Saturday
#
module Schedulicon
  class DayInMonth

    attr_reader :day, :frequency

    def initialize(day, frequency)
      @day, @frequency = day, frequency
    end

    def ordinal
      {
        :every => 0,
        :first => 1,
        :second => 2,
        :third => 3,
        :fourth => 4,
        :last => -1
      }[frequency]
    end
    # Public: generate array of dates for the range
    #
    # starts_at     - DateTime range starts at
    # end_on        - DateTime rande ends on
    #
    # Returns Array of DateTime
    def dates(start_at, end_on)
      start_at.to_datetime.step(end_on).select { |d| week_matches(d) && d.cwday == day }
    end

    # Private: calculates whether date is in the ordinal week for the expression
    #
    def week_matches(date)
      ordinal > 0 ?  week_in_month(date) == ordinal : week_from_end(date) == ordinal.abs
    end

    # Private: calculates the month week number for a date
    #
    def week_in_month(date)
      ((date.day - 1) / 7) + 1
    end

    # Private: calculates the month week number from end of month for a date
    #
    def week_from_end(date)
      last_day = DateTime.new(date.next_month.year, date.next_month.month, 1) - 1
      ((last_day.day - date.day) / 7) + 1
    end
  end
end