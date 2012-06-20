require 'rake'
require 'rspec'
require "#{Rake.application.original_dir}/lib/schedulicon"

include Schedulicon

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true
end
