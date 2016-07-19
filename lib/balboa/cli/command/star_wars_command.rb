# frozen_string_literal: true

module Balboa
  module CLI
    module Command
      class StarWarsCommand
        def execute
          system('telnet towel.blinkenlights.nl')
        end
      end
    end
  end
end
