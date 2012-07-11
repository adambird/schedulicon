# Public: mixin for generating methods required by html forms
#
module Schedulicon
  module Attributes

    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods

      def schedule_attribute(*names)
        names.each do |name|
          define_method(name) { instance_variable_get("@#{name}") || instance_variable_set("@#{name}", Schedule.new) }
          define_method("#{name}=") do |value| instance_variable_set("@#{name}", value) end

          define_method("#{name}_frequency") { send(name).frequency }
          define_method("#{name}_frequency=") do |value| send(name).frequency = value.to_sym unless value.blank? end

          define_method("#{name}_day_of_week") { send(name).day_of_week.to_i }
          define_method("#{name}_day_of_week=") do |value| send(name).day_of_week = value end

          define_method("#{name}_continues") { send(name).end_on ? :until : :forever }
          define_method("#{name}_continues=") do |value| send(name).send("end_on=", nil) if value.to_sym != :until end

          define_method("#{name}_until") { send(name).end_on }
          define_method("#{name}_until=") do |value|
            return unless value
            if value.is_a? String
              return if value.empty?
              value = Time.parse(value)
            end
            send(name).end_on = value
          end
         end
      end
    end
  end
end