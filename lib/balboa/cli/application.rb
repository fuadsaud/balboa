# frozen_string_literal: true

module Balboa
  module CLI
    class Application
      CommandNotFound = Class.new(RuntimeError)

      def initialize(command_id)
        @command_id = command_id.to_s
        @commands = Hash.new { raise CommandNotFound }
      end

      def add_command(key, command)
        @commands[key.to_s] = command
      end

      def execute
        @commands[@command_id].execute
      end
    end
  end
end
