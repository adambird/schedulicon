module Schedulicon
  class DayOfWeek
    
    attr_reader :day
    
    def initialize(day)
      @day = day
    end
    
    def dates(start_at, end_on)
      start_at.step(end_on).select { |d| d.cwday == @day }
    end
  end
end