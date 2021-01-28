#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './app/services/main_app_service'
require 'octokit'

ref, token, owner, repo = ARGV

MainAppService.configure do |config|
  config.client = Octokit::Client.new(access_token: token)
  config.ref = ref
  config.repo = repo
  config.owner = owner
end

MainAppService.new.call
