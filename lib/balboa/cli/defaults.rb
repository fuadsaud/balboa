# frozen_string_literal: true

require 'yaml'
require 'highline'

module Balboa
  module CLI
    class Defaults
      def self.prompt
        new.prompt
      end

      def initialize
        @config = {}
        @cli = HighLine.new
      end

      def prompt
        prompt_attributes

        prompt_schedule

        create_file

        @config
      end

      private

      def create_file
        @config.reject! { |_, key| key.empty? }
        @config.merge!('skips' => [])

        File.open(Balboa::CONFIG_FILE, 'w') { |file| file.write(@config.to_yaml) }
      end

      def prompt_attributes
        @config.merge!('email' => prompt_email)
        @config.merge!('password' => prompt_password)
        @config.merge!('project' => prompt_project)
      end

      def prompt_email
        @cli.ask("E-mail: ")
      end

      def prompt_password
        @cli.say("\nRemember: Password can be stored as text or passed via option!")

        @cli.ask("Password: ") { |qst| qst.echo = "*" }
      end

      def prompt_project
        @cli.ask("\nProject: ")
      end

      def prompt_schedule
        @config.merge!('start_at' => prompt_start)
        @config.merge!('lunch_at' => prompt_lunch)
        @config.merge!('restart_at' => prompt_restart)
        @config.merge!('leave_at' => prompt_leave)
      end

      def prompt_start
        @cli.ask("\nFirst shift: ") { |qst| qst.default = "8" }
      end

      def prompt_lunch
        @cli.ask("\nLunch: ") { |qst| qst.default = "12" }
      end

      def prompt_restart
        @cli.ask("\nSecond shift: ") { |qst| qst.default = "13" }
      end

      def prompt_leave
        @cli.ask("\nLeave: ") { |qst| qst.default = "17" }
      end
    end
  end
end
