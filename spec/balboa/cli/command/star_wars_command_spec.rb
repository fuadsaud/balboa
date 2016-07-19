# frozen_string_literal: true

require 'spec_helper'

describe Balboa::CLI::Command::StarWarsCommand do
  it 'is a trap!' do
    command = described_class.new

    expect(command).to receive(:system).with('telnet towel.blinkenlights.nl')

    command.execute
  end
end
