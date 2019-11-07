module ElevatorSimulation
  class Elevator
    attr_reader :id, :logger

    def initialize(id)
      @id = id
      @logger = ElevatorSimulation.logger
    end


  end
end
