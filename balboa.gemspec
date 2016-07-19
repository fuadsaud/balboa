# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'balboa/version'

Gem::Specification.new do |s|
  s.name          = 'balboa'
  s.version       = Balboa::VERSION
  s.authors       = ['Waldyr de Souza']
  s.email         = ['waldyr.ar@gmail.com']
  s.license       = 'MIT'

  s.summary       = 'Make Balboa do the punches for you'
  s.description   = s.summary

  s.files         = `git ls-files -z`.split("\x0")
  s.require_paths = ['lib']
  s.executables   = ['balboa']

  s.default_executable = 'balboa'

  s.required_ruby_version = '>= 2.0'
end
