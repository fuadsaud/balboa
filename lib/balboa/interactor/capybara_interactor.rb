# frozen_string_literal: true

module Balboa
  module Interactor
    class CapybaraInteractor

      CommandNotFound = Class.new(RuntimeError)

      LoginCommandNotFound = Class.new(RuntimeError)

      attr_reader :options

      def initialize(options={})
        @options = options
        @commands = Hash.new { fail CommandNotFound }
        @signed_in = false
      end
      
      def add_command(key, command)
        @commands[key.to_s] = command
      end

      def last
        login unless signed_in?
        @commands['last'].execute
      end

      def punch(date)
        login unless signed_in?
        @commands['punch'].execute(date)
      end

      private

      attr_accessor :signed_in

      alias_method :signed_in?, :signed_in

      def login
        @commands['login'].execute

        @signed_in = true
      rescue CommandNotFound
        raise LoginCommandNotFound
      end
    end
  end
end
