# -*- encoding: utf-8 -*-
# stub: racksh 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "racksh".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Marcin Kulik".freeze]
  s.date = "2012-10-11"
  s.email = "marcin.kulik@gmail.com".freeze
  s.executables = ["racksh".freeze]
  s.files = ["bin/racksh".freeze]
  s.homepage = "http://github.com/sickill/racksh".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Console for any Rack based ruby web app".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.0"])
      s.add_runtime_dependency(%q<rack-test>.freeze, [">= 0.5"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 1.0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0.5"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 1.0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0.5"])
  end
end
