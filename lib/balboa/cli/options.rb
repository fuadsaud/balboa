# frozen_string_literal: true

require_relative 'parser_builder'

module Balboa
  module CLI
    class Options
      def self.parse(*args)
        new(*args).parse
      rescue OptionParser::InvalidOption => error
        $stderr.puts "Error: #{error}"
        exit
      end

      def initialize(argv=[], config={})
        @config = config
        @parser = Balboa::CLI::ParserBuilder.create(argv, config)
      end

      def parse
        @parser.parse!
        @config
      end
    end
  end
end
