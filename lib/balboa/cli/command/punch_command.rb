# frozen_string_literal: true

require 'holidays'
require 'highline/import'

module Balboa
  module CLI
    module Command
      class PunchCommand
        def initialize(interactor)
          @interactor = interactor
        end

        def execute
          punch_dates.each do |date|
            $stdout.print("\n#{date.strftime("%d/%m/%Y")}")

            @interactor.punch(date) unless skip_date?(date)
          end
        end

        private

        def punch_dates
          yesterday = Date.today - 1

          (last_punch_date..yesterday).map do |date|
            PunchDate.new(date)
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

        class PunchDate
          def initialize(date)
            @date = date
            @holiday = Hash(Holidays.on(@date, :br).first)
          end

          def punchable?
            if weekend?
              false
            elsif holiday?
              ask_for_punch
            else
              true
            end
          end

          def to_s
            @date.to_s
          end

          def strftime(format)
            @date.strftime(format)
          end

          private

          def ask_for_punch
            HighLine.agree(" #{holiday_name}. Punch? (y|n) ")
          end

          def holiday_name
            @holiday[:name]
          end

          def holiday?
            !!@holiday
          end

          def weekend?
            @date.sunday? || @date.saturday?
          end
        end
      end
    end
  end
end
