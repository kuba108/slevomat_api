
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slevomat_api/version"

Gem::Specification.new do |spec|
  spec.name          = "slevomat_api"
  spec.version       = SlevomatApi::VERSION
  spec.authors       = ["Jakub Malina"]
  spec.email         = ["kuba@mixit.cz"]

  spec.summary       = %q{This gem implements Slevomat zbozi API}
  spec.description   = %q{Gem is written according to Slevomat API documentation https://www.slevomat.cz/partner/zbozi-api}
  spec.homepage      = "https://www.mixit.cz/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "'http://rubygems.org'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "faraday", "~> 0.15", ">= 0.15.0"
end
