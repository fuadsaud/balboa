# frozen_string_literal: true

require_relative '../../version'

module Balboa
  module CLI
    module Command
      class HelpCommand
        def execute
          $stdout.puts help 
        end

        private

        def help
        end

        def quote
          "`Life's not about how hard of a hit you can give...'"
        end
      end
    end
  end
end
