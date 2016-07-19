# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/balboa/cli/parser'

describe Balboa::CLI::Parser do
  it 'parses a password option into a hash of configurations' do
    config = {}
    argv = ['-p', 'test']

    described_class.parse(argv, config)

    expect(config).to eq('password' => 'test')
  end

  it 'parses a password full option into a hash of configurations' do
    config = {}
    argv = ['--password', 'test']

    described_class.parse(argv, config)

    expect(config).to eq('password' => 'test')
  end

  it 'parses a project option into a hash of configurations' do
    config = {}
    argv = ['-w', 'test']

    described_class.parse(argv, config)

    expect(config).to eq('project' => 'test')
  end

  it 'parses a project full option into a hash of configurations' do
    config = {}
    argv = ['--project', 'test']

    described_class.parse(argv, config)

    expect(config).to eq('project' => 'test')
  end

  it 'parses a email option into a hash of configurations' do
    config = {}
    argv = ['-e', 'test']

    described_class.parse(argv, config)

    expect(config).to eq('email' => 'test')
  end

  it 'parses a email full option into a hash of configurations' do
    config = {}
    argv = ['--email', 'test']

    described_class.parse(argv, config)

    expect(config).to eq('email' => 'test')
  end

  it 'parses a config option into a hash of configurations' do
    config = {}
    argv = ['-c', 'spec/fixtures/file.yml']

    described_class.parse(argv, config)

    expectation = {
      'email'      => 'email',
      'password'   => 'password',
      'project'    => 'project',
      'start_at'   => '8',
      'lunch_at'   => '12',
      'restart_at' => '13',
      'leave_at'   => '17',
      'skips'      => []
    }
    expect(config).to eq(expectation)
  end

  it 'parses a config full option into a hash of configurations' do
    config = {}
    argv = ['--config', 'spec/fixtures/file.yml']

    described_class.parse(argv, config)

    expectation = {
      'email'      => 'email',
      'password'   => 'password',
      'project'    => 'project',
      'start_at'   => '8',
      'lunch_at'   => '12',
      'restart_at' => '13',
      'leave_at'   => '17',
      'skips'      => []
    }
    expect(config).to eq(expectation)
  end

  it 'raises ENOENT on invalid path to file' do
    config = {}
    argv = ['-c', 'wrong path to file']

    parser = described_class.new(argv, config)

    expect { parser.parse }.to raise_error(Errno::ENOENT)
  end

  it 'parses a skipped date option into a hash of configurations' do
    config = {}
    argv = ['-s', '13/06/1992,15/06/2002']

    described_class.parse(argv, config)

    expectation = {
      'skips' => [
        Date.new(1992, 6, 13), Date.new(2002, 6, 15)
      ]
    }
    expect(config).to eq(expectation)
  end

  it 'raises argument error in case of a wrong date format' do
    config = {}
    argv = ['-s', 'test']

    parser = described_class.new(argv, config)

    expect { parser.parse }.to raise_error(ArgumentError)
  end

  it 'parses a skipped date full option into a hash of configurations' do
    config = {}
    argv = ['--skip', '12/06/1992,12/06/1992']

    described_class.parse(argv, config)

    expectation = {
      'skips' => [
        Date.new(1992, 6, 12), Date.new(1992, 6, 12)
      ]
    }
    expect(config).to eq(expectation)
  end

  it 'parses options that override or fulfill config' do
    config = {
      'password' => '1',
      'project'  => '3'
    }
    argv = ['-p', '3', '-e', '2', '-w', '1']

    described_class.parse(argv, config)

    expectation = {
      'password' => '3',
      'email'    => '2',
      'project'  => '1'
    }

    expect(config).to eq(expectation)
  end

  it 'raises on invalid arguments' do
    config = {}
    argv = ['-z']
    parser = described_class.new(argv, config)

    expect { parser.parse }.to raise_error(OptionParser::InvalidOption)
  end
end
