require 'spec_helper'

describe DayInMonth do
  describe "#dates" do
    before(:each) do
      @start_at = DateTime.new(2012, 6, 1, 19, 0)
      @end_on = DateTime.new(2012, 9, 1, 19, 0)
    end

    subject { DayInMonth.new(@day, @frequency).dates(@start_at, @end_on) }

    context "when 3rd Thursday" do
      before(:each) do
        @day = Schedulicon::THURSDAY
        @frequency = :third
      end

      it "first should be 21 June" do
        subject[0].should eq(DateTime.new(2012, 6, 21, 19, 0))
      end
      it "second should be 19 July" do
        subject[1].should eq(DateTime.new(2012, 7, 19, 19, 0))
      end
      it "third should be 16 August" do
        subject[2].should eq(DateTime.new(2012, 8, 16, 19, 0))
      end
      it "should return 3 items" do
        subject.count.should eq(3)
      end
    end

    context "when last Tuesday" do
      before(:each) do
        @day = Schedulicon::TUESDAY
        @frequency = :last
      end
      it "first should be 26 June" do
        subject[0].should eq(DateTime.new(2012, 6, 26, 19, 0))
      end
      it "second should be 31 July" do
        subject[1].should eq(DateTime.new(2012, 7, 31, 19, 0))
      end
      it "third should be 28 August" do
        subject[2].should eq(DateTime.new(2012, 8, 28, 19, 0))
      end
      it "should return 3 items" do
        subject.count.should eq(3)
      end
    end
  end

  describe "#week_from_end" do

    subject { DayInMonth.new(Schedulicon::THURSDAY, :last).week_from_end(@date) }

    context "when in last week" do
      before(:each) do
        @date = DateTime.new(2012, 6, 28)
      end
      it "is 1" do
        subject.should eq(1)
      end
    end
    context "when in penultimate week" do
      before(:each) do
        @date = DateTime.new(2012, 6, 22)
      end
      it "is 2" do
        subject.should eq(2)
      end
    end

  end
end
