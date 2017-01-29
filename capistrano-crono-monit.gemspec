# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/crono/monit/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-crono-monit'
  spec.version = Capistrano::Crono::Monit::VERSION
  spec.authors = ['Michal Mrozek']
  spec.email = ['michalmrozek@wp.pl']
  spec.description = spec.summary = %q{Monit integration with capistrano-crono}
  spec.homepage = 'https://github.com/Michsior14/capistrano-crono-monit'
  spec.license = 'MIT'

  spec.add_runtime_dependency 'crono'
  spec.add_runtime_dependency 'capistrano', '>= 3.0.0'
  spec.add_runtime_dependency 'capistrano-crono', '0.1.2'

  spec.required_ruby_version = '>= 1.9.3'
  spec.files = `git ls-files`.split('\n')
  spec.require_paths = ['lib']
end
