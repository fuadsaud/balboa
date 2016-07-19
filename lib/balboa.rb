# frozen_string_literal: true

require_relative 'balboa/version'
require_relative 'balboa/config_file'
require_relative 'balboa/host'

require_relative 'balboa/interactor/capybara_interactor'
require_relative 'balboa/interactor/interactor_wrapper'
require_relative 'balboa/interactor/command/fetch_last_punch_command'
require_relative 'balboa/interactor/command/fill_punch_command'
require_relative 'balboa/interactor/command/login_command'

require_relative 'balboa/cli/application'
require_relative 'balboa/cli/defaults'
require_relative 'balboa/cli/command/last_command'
require_relative 'balboa/cli/command/punch_command'
require_relative 'balboa/cli/command/reset_command'
require_relative 'balboa/cli/command/star_wars_command'

require 'phantomjs'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path)
end
Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = Balboa::HOST
