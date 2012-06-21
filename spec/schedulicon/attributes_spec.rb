require 'spec_helper'

class DummyModel
  include Attributes
  schedule_attribute :event_schedule
end

describe Attributes do
  before(:each) do
    @model = DummyModel.new
  end

  describe ".schedule_attribute" do
    context "when root attribute not set" do
      it "returns a Schedule" do
        @model.event_schedule.should be_an_instance_of(Schedule)
      end
      it "frequency should be every" do
        @model.event_schedule_frequency.should eq(:every)
      end
      it "day_of_week should be monday" do
        @model.event_schedule_day_of_week.should eq(Schedulicon::MONDAY)
      end
      it "continues should be forever" do
        @model.event_schedule_continues.should eq(:forever)
      end
      it "until should be nil" do
        @model.event_schedule_until.should be_nil
      end
    end
  end
end