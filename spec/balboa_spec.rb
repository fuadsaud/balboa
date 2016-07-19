# frozen_string_literal: true

require 'spec_helper'

describe Balboa do
  it 'has a version number' do
    expect(Balboa::VERSION).not_to be nil
  end

  it 'has a target host' do
    expect(Balboa::HOST).not_to be nil
  end
end
