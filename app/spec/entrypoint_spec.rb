# frozen_string_literal: true

require 'spec_helper'

describe 'entrypoint' do
  it 'calls the MainAppService service' do
    service_instance = instance_double(MainAppService, call: nil)
    allow(MainAppService).to receive(:new).and_return(service_instance)

    require_relative '../../entrypoint'

    expect(service_instance).to have_received(:call)
  end
end
