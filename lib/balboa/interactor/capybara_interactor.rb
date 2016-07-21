# frozen_string_literal: true

module Balboa
  module Interactor
    class CapybaraInteractor
      def initialize(options)
        @options = options
        @commands = {}
      end
      
      def add_command(key, command)
        @commands[key.to_s] = command
      end

      def last_punch
        login
        @commands['last_punch'].execute
      end

      def punch(date)
        @commands['make_punch'].execute(date)
      end

      private

      def login
        @commands['login'].execute
      end
    end
  end
end
