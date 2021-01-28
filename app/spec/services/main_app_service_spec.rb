# frozen_string_literal: true

require 'spec_helper'

describe MainAppService do
  let(:service) { described_class.new }

  describe '#call' do
    it 'prints hello world' do
      expect { service.call }.to output("hello world\n").to_stdout
    end
  end
end
