
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elevator_simulation/version'

Gem::Specification.new do |spec|
  spec.name          = 'elevator_simulation'
  spec.version       = ElevatorSimulation::VERSION
  spec.authors       = ['Oliver Garcia']
  spec.email         = ['ogarci5@gmail.com']

  spec.summary       = %q{Elevator simulation.}
  spec.description   = %q{Scripts for strategies that work with a variety of elevators and floors.}
  spec.homepage      = 'https://github.com/ogarci5/elevator_simulation'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
