# frozen_string_literal: true

require 'spec_helper'

describe Balboa::CLI::Application do
  it 'stores commands to execute later' do
    app = described_class.new('cmd')
    command = double('command', execute: true)

    app.add_command('cmd', command)

    expect(app.execute).to be true
  end

  it 'coerces command_id to string' do
    app = described_class.new(:cmd)
    command = double('command', execute: true)

    app.add_command('cmd', command)

    expect(app.execute).to be true
  end

  it 'coerces command_key to string' do
    app = described_class.new('cmd')
    command = double('command', execute: true)

    app.add_command(:cmd, command)

    expect(app.execute).to be true
  end

  it 'does not swallow errors from executed command' do
    app = described_class.new('cmd')
    command = double
    allow(command).to receive(:execute).and_raise

    app.add_command(:cmd, command)
    
    expect {
      app.execute
    }.to raise_error(RuntimeError)
  end

  it 'raises error when command not found' do
    app = described_class.new('cmd')

    expect {
      app.execute
    }.to raise_error(Balboa::CLI::Application::CommandNotFound)
  end
end
