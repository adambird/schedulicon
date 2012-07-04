# Public: Represents a day of week expression
#
# examples
#
# DayOfWeek.new(Schedulicon::THURSDAY)  # every Thursday
#
module Schedulicon
  class DayOfWeek

    attr_reader :day

    def initialize(day)
      @day = day
    end

    # Public: generate array of dates for the range
    #
    # starts_at     - DateTime range starts at
    # end_on        - DateTime rande ends on
    #
    # Returns Array of DateTime
    def dates(start_at, end_on)
      start_at.to_datetime.step(end_on).select { |d| d.cwday == @day }
    end
  end
end