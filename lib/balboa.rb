# frozen_string_literal: true

require_relative 'balboa/version'

require_relative 'balboa/interactor/capybara_interactor'
require_relative 'balboa/interactor/interactor_wrapper'
require_relative 'balboa/interactor/command/last_punch_command'
require_relative 'balboa/interactor/command/make_punch_command'
require_relative 'balboa/interactor/command/login_command'

require_relative 'balboa/cli/application'
require_relative 'balboa/cli/command/last_punch_command'
require_relative 'balboa/cli/command/make_punch_command'
require_relative 'balboa/cli/command/star_wars_command'

require 'phantomjs'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path)
end
Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = 'http://punchclock.cm42.io/'
