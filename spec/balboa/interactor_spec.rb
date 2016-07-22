# frozen_string_literal: true

require 'spec_helper'

describe Balboa::Interactor::CapybaraInteractor do
  context 'when no login command' do
    it 'responds to last but raises error' do
      interactor = described_class.new

      last = double('cmd')
      interactor.add_command('last', last)

      error = Balboa::Interactor::CapybaraInteractor::LoginCommandNotFound
      expect { interactor.last }.to raise_error error
    end

    it 'responds to punch but raises error' do
      interactor = described_class.new

      punch = double('cmd')
      interactor.add_command('punch', punch)

      error = Balboa::Interactor::CapybaraInteractor::LoginCommandNotFound
      expect { interactor.punch(Date.today) }.to raise_error error
    end
  end

  it 'responds to last but raises if no command provided' do
    interactor = described_class.new

    last = double('cmd', execute: true)
    login = double('login', execute: true)

    interactor.add_command('login', login)

    error = Balboa::Interactor::CapybaraInteractor::CommandNotFound
    expect {
      interactor.last
    }.to raise_error error
  end

  it 'responds to punch but raises if no command provided' do
    interactor = described_class.new

    punch = double('cmd', execute: nil)
    login = double('login', execute: nil)

    interactor.add_command('login', login)

    error = Balboa::Interactor::CapybaraInteractor::CommandNotFound
    expect {
      interactor.punch(Date.today)
    }.to raise_error error
  end

  it 'signs in only once' do
    interactor = described_class.new

    last = double('cmd', execute: nil)
    punch = double('cmd', execute: nil)
    login = double('login', execute: nil)

    interactor.add_command('punch', punch)
    interactor.add_command('last', last)
    interactor.add_command('login', login)

    interactor.punch(Date.today)
    interactor.last

    expect(login).to have_received(:execute).once
  end

  it 'stores last command to execute whenever called' do
    interactor = described_class.new

    last = double('cmd', execute: Date.today)
    login = double('login', execute: nil)

    interactor.add_command('last', last)
    interactor.add_command('login', login)

    expect(interactor.last).to eq(Date.today)
  end

  it 'stores punch command to execute whenever called' do
    interactor = described_class.new
    today = Date.today

    punch = double('cmd')
    allow(punch).to receive(:execute).with(today).and_return(true)

    login = double('login', execute: nil)

    interactor.add_command('punch', punch)
    interactor.add_command('login', login)

    expect(interactor.punch(today)).to eq(true)
  end
end
