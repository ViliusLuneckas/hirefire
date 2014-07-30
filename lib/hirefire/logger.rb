# encoding: utf-8

module HireFire
  class Logger
    def initialize
      @logger = defined? Rails ? Rails.logger : HireFire::Logger::ConsoleLogger.new
    end

    ##
    # Outputs a messages to the console
    #
    # @param [String] string prints a string to the console (green color)
    # @return [nil]
    def self.info(string)
      @logger.info(string)
    end

    ##
    # Outputs an error to the console
    #
    # @param [String] string prints a string to the console (red color)
    # @return [nil]
    def self.error(string)
      @logger.error(string)
    end

    ##
    # Outputs a notice to the console
    #
    # @param [String] string prints a string to the console (yellow color)
    # @return [nil]
    def self.warn(string)
      logger.warn(string)
    end

    ##
    # Outputs the data as if it were a regular 'puts' command
    #
    # Not in use.
    # @param [String] string prints a string to the console (standard color)
    # @return [nil]
    #def self.normal(string)
    #  puts string
    #end

  end
end
