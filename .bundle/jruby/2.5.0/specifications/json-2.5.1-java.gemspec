# -*- encoding: utf-8 -*-
# stub: json 2.5.1 java lib

Gem::Specification.new do |s|
  s.name = "json".freeze
  s.version = "2.5.1"
  s.platform = "java".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/flori/json/issues", "changelog_uri" => "https://github.com/flori/json/blob/master/CHANGES.md", "documentation_uri" => "http://flori.github.io/json/doc/index.html", "homepage_uri" => "http://flori.github.io/json/", "source_code_uri" => "https://github.com/flori/json", "wiki_uri" => "https://github.com/flori/json/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Luz".freeze]
  s.date = "2020-12-22"
  s.description = "A JSON implementation as a JRuby extension.".freeze
  s.email = "dev+ruby@mernen.com".freeze
  s.homepage = "http://flori.github.com/json".freeze
  s.licenses = ["Ruby".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "2.7.10".freeze
  s.summary = "JSON Implementation for Ruby".freeze

  s.installed_by_version = "2.7.10" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end
