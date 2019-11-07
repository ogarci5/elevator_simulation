module ElevatorSimulation
  class Simulation
    MINIMUM_FLOOR = 1

    attr_reader :logger, :options

    def initialize(options)
      @options = options
      @elevators = options[:elevators] || 1
      @floors = options[:floors] || 2
      @logger = ElevatorSimulation.logger

      if options[:verbose] || options[:verbosity] > 0
        @logger.level = Logger::DEBUG
      else
        @logger.level = Logger::INFO
      end
    end

    def start
      @elevators = @elevators.times.map do |id|
        Elevator.new(id)
      end
    end
  end
end
