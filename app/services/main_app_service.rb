# frozen_string_literal: true

require 'active_support/configurable'

class MainAppService
  include ActiveSupport::Configurable
  config_accessor :client, :ref, :repo, :owner

  def call
    puts 'hello world'
  rescue StandardError => e
    puts e.message
    exit(false)
  end
end
