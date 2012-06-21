require 'time'
require 'date'
require 'rake'
require 'rspec'
require "#{Rake.application.original_dir}/lib/schedulicon"

include Schedulicon

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true
end

def random_string
  (0...24).map{ ('a'..'z').to_a[rand(26)] }.join
end

def random_integer
  rand(9999)
end

def random_time
  Time.now - random_integer
end