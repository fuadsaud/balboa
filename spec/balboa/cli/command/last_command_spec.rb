# frozen_string_literal: true

require 'spec_helper'

describe Balboa::CLI::Command::LastCommand do
  it 'prints out the result of interactor last method' do
    interactor = double('itr', last: 42)

    expect(STDOUT).to receive(:puts).with("\n42")

    described_class.new(interactor).execute
  end
end
