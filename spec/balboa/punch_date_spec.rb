# frozen_string_literal: true

require 'spec_helper'
require 'highline/import'

describe Balboa::PunchDate do
  it 'responds to to_s' do
    date = Date.new(2011, 1, 1)
    punch_date = described_class.new(date, nil)

    expect(punch_date.to_s).to eq('2011-01-01')
  end

  it 'responds to strftime' do
    date = Date.new(2011, 1, 1)
    punch_date = described_class.new(date, nil)

    expect(punch_date.strftime('%d/%m/%Y')).to eq('01/01/2011')
  end

  context 'punchable' do
    it 'returns false on satudays' do
      date = Date.new(2011, 1, 1)
      punch_date = described_class.new(date, nil)

      expect(punch_date.punchable?).to be false
    end

    it 'returns false on sundays' do
      date = Date.new(2011, 1, 2)
      punch_date = described_class.new(date, nil)

      expect(punch_date.punchable?).to be false
    end

    it 'returns true on a week day that is not a holiday' do
      date = Date.new(2011, 1, 3)
      punch_date = described_class.new(date, nil)

      expect(punch_date.punchable?).to be true
    end

    it 'returns true if user says yes on holidays' do
      input = StringIO.new("no\n")
      output = StringIO.new
      cli = HighLine.new(input, output)

      date = Date.new(2011, 4, 21)
      punch_date = described_class.new(date, cli)

      expect(punch_date.punchable?).to be false
    end

    it 'returns false if user says no on holidays' do
      input = StringIO.new("yes\n")
      output = StringIO.new
      cli = HighLine.new(input, output)

      date = Date.new(2011, 4, 21)
      punch_date = described_class.new(date, cli)

      expect(punch_date.punchable?).to be true
    end
  end
end
