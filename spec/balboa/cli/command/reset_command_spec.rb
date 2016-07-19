# frozen_string_literal: true

require 'spec_helper'

describe Balboa::CLI::Command::ResetCommand do
  it 'deletes the .balboa.yml file' do
    expect(File).to receive(:delete).with('.balboa.yml')

    described_class.new.execute
  end

  it 'prints out a success message' do
    success_message = "\nBalboa restored to initial settings!"

    allow(File).to receive(:delete).with('.balboa.yml')

    expect(STDOUT).to receive(:puts).with(success_message)

    described_class.new.execute
  end
end
