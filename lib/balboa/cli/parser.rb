# frozen_string_literal: true

require 'optparse'
require 'yaml'

module Balboa
  module CLI
    class Parser
      def self.parse(*args)
        new(*args).parse
      end

      def initialize(argv, default_config)
        @config = default_config
        @argv = argv
        @parser = OptionParser.new
      end

      def parse
        configure_parser

        @parser.parse!(@argv)
      end

      private

      def configure_parser
        program_name = @parser.program_name

        @parser.banner = <<-EOF.gsub(/^[ ]+/, '')
          \nUsage: #{program_name} [commands] [options]"

          Commands:

          #{program_name} last
          #{program_name} punch -p '123456' -s '12/06/1992,13/06/1992,14/06/1992'
          #{program_name} reset
        EOF

        set_options
        set_utilities
      end

      def set_options
        @parser.separator "\nOptions:"
        set_attributes
        set_skipped_dates
        set_custom_defaults
      end

      def set_utilities
        @parser.separator "\nUtilities:"
        set_help_option
        set_version_option
        set_balboa_picture
      end

      def set_custom_defaults
        message = 'Read configuration options from FILE'

        @parser.on('-c', '--config \'FILE\'', message) do |file|
          @config.merge!(YAML.load_file(file))
        end
      end

      # :reek:TooManyStatements
      def set_attributes
        @parser.on('-e', '--email \'EMAIL\'') do |email|
          @config['email'] = email
        end

        @parser.on('-p', '--password \'PASSWORD\'') do |password|
          @config['password'] = password
        end

        @parser.on('-w', '--project \'PROJECT\'') do |project|
          @config['project'] = project
        end
      end

      def set_skipped_dates
        message = 'Skip input dates'

        @parser.on('-s', '--skip \'DATES\'', message, Array) do |dates|
          parse_dates(dates)
        end
      end

      def parse_dates(dates)
        @config.merge!('skips' => dates.map { |date| Date.parse(date) })
      end

      def set_help_option
        @parser.on('-h', '--help', 'Show this message') do
          $stdout.puts @parser
          exit
        end
      end

      def set_version_option
        @parser.on('-v', '--version', 'Show version') do
          $stdout.puts "#{@parser.program_name} #{Balboa::VERSION}\n"
          exit
        end
      end

      # rubocop:disable Metrics/MethodLength
      def set_balboa_picture
        @parser.separator("\n" + [
          '░░░░░░▄▄███████████████▄▄░░░░',
          '░░░▄██████████████████████▄░░',
          '░░█████████▀███████▀████████░',
          '░█████████▀▀█▀█░░▀██▄██▄████░',
          '░░████████▄▄█░▀▀▄▄█░░▀░████░░',
          '░░███████▀░░░▄▄▄▄░░░▄▄▄███░░░',
          '░▀███████░░▄▀▀██▀░░█▄░▄▀███░░',
          '░░██████▀░░█░██▀▀░░████░██░░░',
          '░████████░░░░▀▀░░░░▀▄░▀▀█░░░░',
          '░█▀██████░░░░░░░░░░░░█░░█░░░░',
          '░▀▄████▄▀░░░░░░░░░░░▀▀░░░█░░░',
          '░▄██████▀▄░░░░░░░░░▄▄▄░░░█░░░',
          '░███████░█░░░░░░░░██▄▄█░░░█░░',
          '░░██████░░█░░░░░░░░░░░░░░░█░░',
          '░▀▄█████░░░▀▄░░░░░░░░░░░░▄▀░░',
          '░░░░███▀░░░░░▀▀▀█▄▄▄░░░░█▀░░░',
          '░░░░▄▀░░░░░░░░░▀▄░░░██▀▀▀░░░░',
          '░░▄▀░░░░░░░░░░░░░░▀░░▀▀▀▀▀▄░░',
          '▄▀░░░░░░░░░░░░░░░░░░░░░░▄░█▀▄'
        ].join("\n"))
      end
    end
  end
end
