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
      Elevator.prepare_elevators(number: @elevators)

      loop do
        random_floor = Random.rand(@floors) + 1
        Elevator.request(floor: random_floor)

        sleep 1
      end
    end
  end
end
