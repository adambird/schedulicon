require 'spec_helper'

describe DayOfWeek do
  describe "#dates" do
    before(:each) do
      @start_at = DateTime.new(2012, 6, 1, 19, 0)
      @end_on = DateTime.new(2012, 7, 1, 19, 0)
    end
    
    context "when Monday" do
      before(:each) do
        @day = Schedulicon::MONDAY
      end
      
      subject { DayOfWeek.new(@day).dates(@start_at, @end_on) }
      
      it "first should be 4 June" do
        subject[0].should eq(DateTime.new(2012, 6, 4, 19, 0))
      end
      it "second should be 11 June" do
        subject[1].should eq(DateTime.new(2012, 6, 11, 19, 0))
      end
      it "third should be 18 June" do
        subject[2].should eq(DateTime.new(2012, 6, 18, 19, 0))
      end
      it "fourth should be 25 June" do
        subject[3].should eq(DateTime.new(2012, 6, 25, 19, 0))
      end
      it "should return 4 items" do
        subject.count.should eq(4)
      end
    end
  end
    
end
