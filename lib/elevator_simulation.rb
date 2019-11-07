require 'elevator_simulation/elevator'
require 'elevator_simulation/simulation'
require 'elevator_simulation/version'
require 'optparse'
require 'logger'

module ElevatorSimulation
  def self.parse(arguments)
    options = {}
    OptionParser.new do |parser|
      parser.banner = 'Usage: elevator_simulation command [options]'
      parser.separator ''
      parser.separator 'Specific options:'

      parser.on('--elevators NUMBER', Integer, 'Set the number of elevators') do |n|
        options[:elevators] = n
      end

      parser.on('--floors NUMBER', Integer, 'Set the number of floors') do |n|
        options[:floors] = n
      end

      parser.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
        options[:verbose] = v
      end

      parser.on('--verbosity LEVEL', Integer, 'Set verbosity level') do |v|
        options[:verbosity] = v
      end

      parser.on('--version', 'Show the installed version') do
        puts VERSION
        exit
      end

      parser.on('-h', '--help', 'Display this screen') do
        puts parser
        exit
      end

      parser.parse!(arguments)
    end

    # default options
    options[:verbosity] ||= 0
    simulation = Simulation.new(options)
    simulation.start
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
