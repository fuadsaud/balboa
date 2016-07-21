# frozen_string_literal: true

module Balboa
  module CLI
    module Command
      class MakePunchCommand
        def initialize(interactor, holidays)
          @interactor = interactor
          @holidays = holidays.uniq.map { |holiday| Date.parse(holiday) }
        end

        def execute
          punch_dates.each do |date|
            if date.saturday? || date.sunday?
              $stdout.puts "#{date} # WEEKEND"
            elsif holiday?(date)
              $stdout.puts "#{date} # HOLIDAY"
            else
              @interactor.punch(date)
            end
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
          Date.parse(@interactor.last_punch) + 1
        end
      end
    end
  end
end
