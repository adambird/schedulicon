require 'spec_helper'

describe Schedule do
  describe ".load" do
    before(:each) do
      @frequency = :first
      @day_of_week = Schedulicon::WEDNESDAY
      @start_at = random_time
    end

    subject { Schedule.load({'frequency' => @frequency.to_s, 'day_of_week' => @day_of_week.to_s, 'start_at' => @start_at.xmlschema }) }

    it "sets the start time" do
      subject.start_at.to_s.should eq(@start_at.to_s)
    end
    it "sets the day_of_week" do
      subject.day_of_week.should eq(@day_of_week)
    end
    it "sets the day on the expression" do
      subject.frequency.should eq(@frequency)
    end
  end

  describe "#to_hash" do
    before(:each) do
      @schedule = Schedule.new
      @schedule.frequency = :first
      @schedule.day_of_week = Schedulicon::WEDNESDAY
      @schedule.start_at = random_time
      @schedule.end_on = random_time
    end

    subject { @schedule.to_hash }

    it "sets the start time" do
      subject['start_at'].should eq(@schedule.start_at.xmlschema)
    end
    it "sets the start time" do
      subject['end_on'].should eq(@schedule.end_on.xmlschema)
    end
    it "sets the day_of_week" do
      subject['day_of_week'].should eq(@schedule.day_of_week)
    end
    it "sets the day on the expression" do
      subject['frequency'].should eq(@schedule.frequency)
    end
  end

  describe "#expression" do
    before(:each) do
      @schedule = Schedule.new
    end

    subject { @schedule.expression }

    context "when every Friday" do
      before(:each) do
        @schedule.day_of_week = Schedulicon::FRIDAY
        @schedule.frequency = :every
      end
      it "should be a DayOfWeek" do
        subject.should be_an_instance_of(DayOfWeek)
      end
      it "should have Friday as the day" do
        subject.day.should eq(Schedulicon::FRIDAY)
      end
    end

    context "when 3rd Tuesday of the month" do
      before(:each) do
        @schedule.day_of_week = Schedulicon::TUESDAY
        @schedule.frequency = :third
      end
      it "should be a DayInMonth" do
        subject.should be_an_instance_of(DayInMonth)
      end
      it "should have Tuesday as the day" do
        subject.day.should eq(Schedulicon::TUESDAY)
      end
      it "should have 3 as the ordinal" do
        subject.ordinal.should eq(3)
      end
    end

    context "when last Sunday of the month" do
      before(:each) do
        @schedule.day_of_week = Schedulicon::SUNDAY
        @schedule.frequency = :last
      end
      it "should be a DayInMonth" do
        subject.should be_an_instance_of(DayInMonth)
      end
      it "should have Tuesday as the day" do
        subject.day.should eq(Schedulicon::SUNDAY)
      end
      it "should have 3 as the ordinal" do
        subject.ordinal.should eq(-1)
      end
    end
  end

  describe "#dates" do
    before(:each) do
      @schedule = Schedule.new
      @schedule.start_at = @start_at = random_time
      @schedule.end_on = @end_on = random_time
      @expression = mock('Expression', :dates => [])
      @schedule.stub(:expression) { @expression }
      @from = random_time
      @to = random_time
    end

    subject { @schedule.dates(@from, @to) }

    it "calls the expression#dates with args" do
      @expression.should_receive(:dates).with(@from, @to)
      subject
    end
    context "when no argumens passed" do
      before(:each) do
        @from = nil
        @to = nil
      end
      it "calls the expression#dates with args" do
        @expression.should_receive(:dates).with(@start_at, @end_on)
        subject
      end
      context "when end_on is nil" do
        before(:each) do
          @schedule.end_on = nil
        end
        it "calls end as 12 months from start" do
          @expression.should_receive(:dates).with(@start_at, @start_at.to_date >> 12)
          subject
        end
      end
    end
  end
end
