# frozen_string_literal: true

require 'yaml'

module Balboa
  module CLI
    class Defaults
      TOTAL_WORK_HOURS = 8

      def self.prompt(*args)
        new(*args).prompt
      end

      def initialize(cli, config = {})
        @config = config
        @cli = cli
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
        @config['skips'] = []

        File.open(Balboa::CONFIG_FILE, 'w') do |file|
          file.write(@config.to_yaml)
        end
      end

      def prompt_attributes
        @cli.say("\nFirst run. Please type your settings!")

        @config['email'] = prompt_email
        @config['password'] = prompt_password
        @config['project'] = prompt_project
      end

      def prompt_email
        @cli.ask('E-mail: ')
      end

      def prompt_password
        @cli.say("\nPassword can be stored as text or passed via option!")

        @cli.ask('Password: ') { |qst| qst.echo = '*' }
      end

      def prompt_project
        @cli.ask("\nProject: ")
      end

      def prompt_schedule
        @config['start_at'] = prompt_start
        @config['lunch_at'] = prompt_lunch
        @config['restart_at'] = prompt_restart
        @config['leave_at'] = prompt_leave
      end

      def prompt_start
        @cli.ask("\nFirst shift: ") { |qst| qst.default = '8' }
      end

      def prompt_lunch
        default = @config['start_at'].to_i + 4

        @cli.ask("\nLunch: ") { |qst| qst.default = default.to_s }
      end

      def prompt_restart
        default = @config['lunch_at'].to_i + 1

        @cli.ask("\nSecond shift: ") { |qst| qst.default = default.to_s }
      end

      def prompt_leave
        default = TOTAL_WORK_HOURS
        default -= @config['lunch_at'].to_i - @config['start_at'].to_i
        default += @config['restart_at'].to_i

        @cli.ask("\nLeave: ") { |qst| qst.default = default.to_s }
      end
    end
  end
end
