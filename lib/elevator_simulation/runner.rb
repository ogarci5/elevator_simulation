require 'logger'
require 'json'
require 'csv'

module ElevatorSimulation
  class Runner
    attr_reader :logger

    def initialize(options)
      @options = options
      @elevators = options[:elevators]
      @floors = options[:floors]
      @logger = ElevatorSimulation.logger

      if options[:verbose] || options[:verbosity] > 0
        @logger.level = Logger::DEBUG
      else
        @logger.level = Logger::INFO
      end
    end

    def run
      #call stuff here
    end
  end
end
