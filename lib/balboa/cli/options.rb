# frozen_string_literal: true

require 'optparse'
require 'yaml'

module Balboa
  module CLI
    class Options
      ERROR_EXIT_CODE   = 1
      BALBOA_FILE       = '.balboa'.freeze

      MissingOptionError = Class.new(RuntimeError)

      def self.parse(shifted_argv=[])
        new(shifted_argv).parse
      rescue OptionParser::InvalidOption => error
        $stderr.puts "Error: #{error}"
        exit ERROR_EXIT_CODE
      end

      def initialize(shifted_argv)
        @parser = OptionParser.new(shifted_argv)
        @config = Hash.new { fail MissingOptionError }

        configure_parser
      end

      def parse
        @parser.parse!

        @config
      end

      private

      def configure_parser
        load_balboa_file
        load_config_file
        load_params
      end

      def load_balboa_file
        @config.merge!(YAML.load_file(BALBOA_FILE)) if File.exists?(BALBOA_FILE)
      end
      
      def load_config_file
        @parser.on('-c', '--config FILE') do |file|
          @config.merge!(YAML.load_file(file)) if File.exists?(file)
        end
      end

      def load_params
        @parser.on('-d', '--data PARAMS') do |data|
          @config.merge!(data)
        end
      end
    end
  end
end
