# frozen_string_literal: true

require_relative '../../punch_date'

module Balboa
  module CLI
    module Command
      class PunchCommand
        def initialize(interactor, cli)
          @interactor = interactor
          @cli = cli
        end

        def execute
          punch_dates.reject! { |date| skip_date?(date) }

          punch_dates.each do |date|
            $stdout.print("\n#{date.strftime('%d/%m/%Y')}")
            @interactor.punch(date)
          end
        end

        private

        def punch_dates
          yesterday = Date.today - 1

          (last_punch_date..yesterday).map do |date|
            PunchDate.new(date, @cli)
          end
        end

        def skip_date?(date)
          !date.punchable? || skips_include?(date)
        end

        def skips_include?(date)
          @interactor.options['skips'].include?(date)
        end

        def last_punch_date
          Date.parse(@interactor.last) + 1
        end
      end
    end
  end
end
