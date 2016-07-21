# frozen_string_literal: true

require 'capybara/dsl'

module Balboa
  module Interactor
    module Command
      class MakePunchCommand
        include Capybara::DSL

        def initialize(options)
          @options = options
        end

        def execute(date)
          visit_new_punch_path

          fill_first_shift(date)

          visit_new_punch_path

          fill_second_shift(date)
        end

        private

        def visit_new_punch_path
          visit('/punches/new')
        end

        def fill_first_shift(date)
          fill_form(date, @options['start_at'], @options['lunch_at'])

          confirm
        end

        def fill_second_shift(date)
          fill_form(date, @options['restart_at'], @options['leave_at'])

          confirm
        end

        def fill_form(date, start_time, finish_time)
          fill_in 'punch[from_time]', with: start_time
          fill_in 'punch[to_time]', with: finish_time
          fill_in 'punch[when_day]', with: date.to_s
          select @options['project'], from: 'punch[project_id]'
        end

        def confirm
          click_button 'Criar Punch'
        end
      end
    end
  end
end
