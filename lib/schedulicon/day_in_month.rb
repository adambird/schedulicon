module Schedulicon
  class DayInMonth
    
    attr_reader :day, :ordinal
    
    def initialize(day, ordinal)
      @day, @ordinal = day, ordinal
    end
    
    def dates(start_at, end_on)
      start_at.step(end_on).select { |d| week_matches(d) && d.cwday == day }
    end
    
    def week_matches(date)
      ordinal > 0 ?  week_in_month(date) == ordinal : week_from_end(date) == ordinal.abs
    end
    
    def week_in_month(date)
      ((date.day - 1) / 7) + 1
    end
    
    def week_from_end(date)
      last_day = DateTime.new(date.next_month.year, date.next_month.month, 1) - 1
      ((last_day.day - date.day) / 7) + 1
    end
  end
end