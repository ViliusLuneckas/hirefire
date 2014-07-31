# encoding: utf-8

require File.expand_path('../spec_helper', __FILE__)

require 'timecop'

describe HireFire::Logger do

  before do
    Timecop.freeze( Time.now )
  end

  context 'when executed outside rails' do
    it 'receives an info message and writes it to the standard output' do
      HireFire::Logger::ConsoleLogger.expects(:puts).with("[#{ Time.now.strftime("%Y-%m-%d %H:%M:%S") }][\e[32mHireFire\e[0m] This has been logged.")

      HireFire::Logger.instance.info "This has been logged."
    end

    it 'receives an error message and writes it to the standard output' do
      HireFire::Logger::ConsoleLogger.expects(:puts).with("[#{ Time.now.strftime("%Y-%m-%d %H:%M:%S") }][\e[31mHireFire\e[0m] This has been logged.")

      HireFire::Logger.instance.error "This has been logged."
    end

    it 'receives a warning message and writes it to the standard output' do
      HireFire::Logger::ConsoleLogger.expects(:puts).with("[#{ Time.now.strftime("%Y-%m-%d %H:%M:%S") }][\e[33mHireFire\e[0m] This has been logged.")

      HireFire::Logger.instance.warn "This has been logged."
    end
  end

  context 'when running within rails' do
    before(:each) do                                                            
      Rails = mock()
      @logger = mock()
      Rails.stubs(:logger).returns(@logger)
      @logger_class = HireFire::Logger.clone                                
    end 

    it 'receives an info message and writes it to the logger' do
      @logger.expects(:info).with("This has been logged.")

      @logger_class.instance.info "This has been logged."
    end

    it 'receives an error message and writes it to the logger' do
      @logger.expects(:error).with("This has been logged.")

      @logger_class.instance.error "This has been logged."
    end

    it 'receives a warning message and writes it to the logger' do
      @logger.expects(:warn).with("This has been logged.")

      @logger_class.instance.warn "This has been logged."
    end
  end

end
