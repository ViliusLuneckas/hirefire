# encoding: utf-8

module HireFire

  class Logger
    autoload :ConsoleLogger, 'hirefire/logger/console_logger'
    include Singleton


    def initialize
      if defined? Rails
        @logger = Rails.logger
      else
        @logger = Logger::ConsoleLogger.new
      end
    end

    ##
    # Outputs a messages to the console
    #
    # @param [String] string logs a string on the info level
    # @return [nil]
    def info(string)
      @logger.info(string)
    end

    ##
    # Outputs an error to the console
    #
    # @param [String] string logs a string on the error level
    # @return [nil]
    def error(string)
      @logger.error(string)
    end

    ##
    # Outputs a notice to the console
    #
    # @param [String] string logs a string on the warn level
    # @return [nil]
    def warn(string)
      @logger.warn(string)
    end

  end
end
