# frozen_string_literal: true

require 'spec_helper'

describe Balboa::Interactor::InteractorWrapper do
  it 'forwards punch call to its dependency' do
    today = Date.today

    interactor = double
    allow(interactor).to receive(:punch).with(today)

    described_class.new(interactor).punch(today)

    expect(interactor).to have_received(:punch).with(today).once
  end

  it 'forwards last call to its dependency' do
    interactor = double
    allow(interactor).to receive(:last)

    described_class.new(interactor).last

    expect(interactor).to have_received(:last).once
  end

  it 'forwards options call to its dependency' do
    interactor = double
    allow(interactor).to receive(:options)

    described_class.new(interactor).options

    expect(interactor).to have_received(:options).once
  end
end
