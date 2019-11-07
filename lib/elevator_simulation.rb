require 'elevator_simulation/version'
require 'optparse'

module ElevatorSimulation
  def self.parse(arguments)
  end

  def self.logger
    if @logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
      @logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime}][#{severity}] #{msg}\n"
      end
    end
    @logger
  end
end
