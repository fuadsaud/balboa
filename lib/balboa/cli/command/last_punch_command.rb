# frozen_string_literal: true

module Balboa
  module CLI
    module Command
      class LastPunchCommand
        def initialize(interactor)
          @interactor = interactor
        end

        def execute
          @interactor.last_punch
        end
      end
    end
  end
end
