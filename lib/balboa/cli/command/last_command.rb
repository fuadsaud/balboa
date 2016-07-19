# frozen_string_literal: true

module Balboa
  module CLI
    module Command
      class LastCommand
        def initialize(interactor)
          @interactor = interactor
        end

        def execute
          $stdout.puts(@interactor.last)
        end
      end
    end
  end
end
