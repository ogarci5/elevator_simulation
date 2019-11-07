module ElevatorSimulation
  class Elevator
    # One floor moved per 10 seconds.
    VELOCITY = 0.1
    # Wait time at a floor for people to get in and out.
    WAIT_TIME = 30
    # Maximum number of trips before maintenance is needed
    MAXIMUM_TRIPS = 100

    attr_reader :id, :current_floor, :trips, :logger

    class << self
      attr_reader :elevators

      def all
        @elevators
      end

      def prepare_elevators(number: 1)
        @elevators = number.times.map { |n| Elevator.new(n) }
      end

      def request(floor:)
        # DO stuff
      end
    end

    def initialize(id)
      @id = id
      @logger = ElevatorSimulation.logger
      @current_floor = 1
      @trips = 0
    end
  end
end
