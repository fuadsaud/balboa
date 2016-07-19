# frozen_string_literal: true

module Balboa
  module CLI
    module Command
      class ResetCommand
        def execute
          File.delete(Balboa::CONFIG_FILE)

          $stdout.puts(message)
        end

        def message
          "\nBalboa restored to initial settings!"
        end
      end
    end
  end
end
