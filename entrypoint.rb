#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './app/services/main_app_service'
require 'octokit'
event = JSON.parse(File.read(ENV['GITHUB_EVENT_PATH']))
pull_request = event['pull_request']

MainAppService.configure do |config|
  config.client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  config.ref = ENV['GITHUB_SHA']
  config.repo = ENV['GITHUB_REPOSITORY']
  config.workspace = ENV['GITHUB_WORKSPACE'] #  a copy of your repository if your workflow uses the actions/checkout action
  config.pr_id = pull_request['number'].to_i
end

MainAppService.new.call
