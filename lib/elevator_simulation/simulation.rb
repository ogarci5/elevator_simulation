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
      Elevator.prepare(number: @elevators)

      # We assume here that actions happen every second
      loop do
        request_floor = Random.rand(@floors) + 1
        destination_floor = Random.rand(@floors) + 1

        # To make sure we are requesting a different floor
        while request_floor == destination_floor
          destination_floor = Random.rand(@floors) + 1
        end

        result = Elevator.request(request_floor: request_floor, destination_floor: destination_floor)
        break if result

        sleep 1

        Elevator.update_all
      end
    end
  end
end
