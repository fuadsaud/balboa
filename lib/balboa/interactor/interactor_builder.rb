# frozen_string_literal: true

require_relative 'capybara_interactor'
require_relative 'command/fetch_last_punch_command'
require_relative 'command/fill_punch_command'
require_relative 'command/login_command'

module Balboa
  module Interactor
    class InteractorBuilder
      def self.create(*args)
        new(*args).create
      end

      def initialize(options)
        @options = options
        @interactor = Balboa::Interactor::CapybaraInteractor.new(options)
      end
      
      def create
        last_punch = Balboa::Interactor::Command::FetchLastPunchCommand.new

        @interactor.tap do |itr|
          itr.add_command(:punch, fill_punch)
          itr.add_command(:last, last_punch)
          itr.add_command(:login, login)
        end
      end

      private

      def fill_punch
        Balboa::Interactor::Command::FillPunchCommand.new(@options)
      end

      def login
        Balboa::Interactor::Command::LoginCommand.new(@options)
      end
    end
  end
end
