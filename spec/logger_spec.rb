# encoding: utf-8

describe HireFire::Logger do
  before { Timecop.freeze(Time.now) }

  let(:message) { 'This has been logged.' }
  let(:logger) { HireFire::Logger.clone.instance }
  let(:console_logger) { HireFire::Logger::ConsoleLogger }

  context 'when executed outside rails' do
    let(:time_str) { Time.now.strftime('%Y-%m-%d %H:%M:%S') }

    it 'receives an info message and writes it to the standard output' do
      console_logger.expects(:puts).with("[#{time_str}][\e[32mHireFire\e[0m] #{message}")

      logger.info message
    end

    it 'receives an error message and writes it to the standard output' do
      console_logger.expects(:puts).with("[#{time_str}][\e[31mHireFire\e[0m] #{message}")

      logger.error message
    end

    it 'receives a warning message and writes it to the standard output' do
      console_logger.expects(:puts).with("[#{time_str}][\e[33mHireFire\e[0m] #{message}")

      logger.warn message
    end
  end

  context 'when running within rails' do
    let(:rails_logger) { mock }

    before do
      defined?(Rails) ? Kernel.stubs(:Rails).returns(mock) : Rails = mock
      Rails.stubs(:logger).returns(rails_logger)
    end

    it 'receives an info message and writes it to the logger' do
      rails_logger.expects(:info).with(message)

      logger.info message
    end

    it 'receives an error message and writes it to the logger' do
      rails_logger.expects(:error).with(message)

      logger.error message
    end

    it 'receives a warning message and writes it to the logger' do
      rails_logger.expects(:warn).with(message)

      logger.warn message
    end
  end
end
