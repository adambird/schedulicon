require 'spec_helper'

describe Schedulicon do
  describe "#generate_schedule" do
    before(:each) do
      @start_at = DateTime.new(2012, 6, 1, 19, 0)
      @end_on = DateTime.new(2012, 7, 1, 19, 0)
    end
    
    subject { Schedulicon.generate(@start_at, @end_on, @expression) }
    
    context "when nDayofWeek expression" do
      before(:each) do
        @expression = DayOfWeek.new(Schedulicon::MONDAY)
      end
      it "first should be 4 June" do
        subject[0].should eq(DateTime.new(2012, 6, 4, 19, 0))
      end
    end
  end
end
