# frozen_string_literal: true

module Balboa
  module CLI
    module Command
      class PunchCommand
        def initialize(interactor, holidays)
          @interactor = interactor
          @holidays = holidays.uniq.map { |holiday| Date.parse(holiday) }
        end

        def execute
          punch_dates.each do |date|
            $stdout.print(date.strftime("%d/%m/%Y"))

            if date.saturday? || date.sunday? || holiday?(date)
              $stdout.print(" # SKIPPED")
            else
              @interactor.punch(date)
            end

            $stdout.print("\n")
          end
        end

        private

        def punch_dates
          yesterday = Date.today - 1

          (last_punch_date..yesterday)
        end

        def holiday?(date)
          @holidays.include?(date)
        end

        def last_punch_date
          Date.parse(@interactor.last) + 1
        end
      end
    end
  end
end
