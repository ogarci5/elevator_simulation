module ElevatorSimulation
  class Elevator
    # One floor moved per second.
    VELOCITY = 1
    # Wait time at a floor for people to get in and out.
    WAIT_TIME = 3
    # Maximum number of trips before maintenance is needed
    MAXIMUM_TRIPS = 100

    attr_reader :id, :current_floor, :state, :trips, :logger

    class << self
      attr_reader :elevators

      def all
        @elevators
      end

      def prepare(number: 1)
        @elevators = number.times.map { |n| Elevator.new(n) }
      end

      def request(request_floor:, destination_floor:)
        return false unless @elevators.any?(&:available?)

        ElevatorSimulation.logger.info "Elevator requested at floor #{request_floor} to go to floor #{destination_floor}"

        # Find first elevator that's closest to that floor
        elevator = find_closest(floor: request_floor)
        elevator.goto(request_floor: request_floor, destination_floor: destination_floor)
        elevator.details

        true
      end

      def find_closest(floor:)
        # Needs to be improved to prioritize
        # 1. Idle
        # 2. Closest going the same direction
        # 3. Closest going opposite direction
        @elevators.min_by { |elevator| [elevator.distance_from_floor(floor), elevator.id] }
      end

      def update_all
        time = Time.now.to_f
        @elevators.each { |elevator| elevator.update(time) }
      end
    end

    def initialize(id)
      @id = id
      @logger = ElevatorSimulation.logger
      @current_floor = 1

      @trips = 0
      @state = :idle
      @door_state = :closed
    end

    def running?
      @state == :running
    end

    def idle?
      @state == :idle
    end

    def unavailable?
      @state == :unavailable
    end

    def available?
      !unavailable?
    end

    def doors_open?
      @door_state == :open
    end

    def doors_closed?
      @door_state == :closed
    end

    # TODO Split this out into different methods
    def update(time)
      return if idle?

      logger.info "updating elevator #{id}"
      details

      if doors_open?
        wait_time = (@door_timer + WAIT_TIME).round
        if wait_time == time.round
          @door_state = :closed
          @door_timer = nil

          # We have reached the destination
          if @destination_floor == @current_floor
            @trips += 1
            @trip_timer = nil
            @state = :idle
            if @trips >= MAXIMUM_TRIPS
              @state = :unavailable
            end
          end
        end
      else
        # doors closed
        distance = VELOCITY * (time - @movement_timer).round
        if @direction == :up
          @current_floor += distance
        elsif @direction == :down
          @current_floor -= distance
        end

        # We have reached the destination
        if @destination_floor == @current_floor
          @movement_timer = nil
          @door_state = :open
          @door_timer = time
        end
      end
    end

    def distance_from_floor(floor)
      @current_floor - floor
    end

    def goto(request_floor:, destination_floor:)
      time = Time.now.to_f
      @trip_timer = time
      @movement_timer = time
      @request_floor = request_floor
      @destination_floor = destination_floor
      @state = :running
      @direction = (@destination_floor - @current_floor).positive? ? :up : :down

      if distance_from_floor(@request_floor) == 0
        @door_state = :open
        @door_timer = time
      end
    end

    def details
      details = <<~DETAILS
        id: #{id}, current_floor: #{@current_floor}, trips: #{@trips}, state: #{@state}, trip_timer: #{@trip_timer&.round}, 
        movement_timer: #{@movement_timer&.round}, direction: #{@direction}, door_state: #{@door_state}, door_timer: #{@door_timer&.round}, 
        request_floor: #{@request_floor}, destination_floor: #{@destination_floor}
      DETAILS
      logger.info details
    end
  end
end
