# frozen_string_literal: true

require 'holidays'

module Balboa
  class PunchDate
    def initialize(date, cli)
      @date = date
      @cli = cli
      @holiday = Hash(Holidays.on(date, :br).first)
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
      @cli.agree(" #{holiday_name}. Punch? (y|n) ")
    end

    def holiday_name
      @holiday[:name]
    end

    def holiday?
      !@holiday.empty?
    end

    def weekend?
      @date.sunday? || @date.saturday?
    end
  end
end
