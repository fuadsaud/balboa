# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../lib/balboa/interactor/interactor_builder'

describe Balboa::Interactor::InteractorBuilder do
  it 'responds to create as class method' do
    interactor = described_class.create({})

    expect(interactor).not_to be nil
  end

  it 'responds to create as instance method' do
    interactor = described_class.new({}).create

    expect(interactor).not_to be nil
  end
end
