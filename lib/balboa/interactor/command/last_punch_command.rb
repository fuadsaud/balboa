# frozen_string_literal: true

require 'capybara/dsl'

module Balboa
  module Interactor
    module Command
      class LastPunchCommand
        include Capybara::DSL

        def execute
          punches_path

          find_last_punch_date
        end

        private

        def punches_path
          visit('/punches')
        end

        def find_last_punch_date
          find('tbody tr:first-child td:nth-child(2)').text
        end
      end
    end
  end
end
