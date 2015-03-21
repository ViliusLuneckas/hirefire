# encoding: utf-8

require 'rubygems'
require 'bundler/setup'

require 'hirefire'
require 'timecop'
require 'support/configuration_helper'

RSpec.configure do |config|
  config.mock_with :mocha
end
