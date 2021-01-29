#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './app/services/main_app_service'
require 'octokit'

pull_request_nr = `PR_NUMBER=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')`

p pull_request_nr # debug
return unless pull_request_nr

MainAppService.configure do |config|
  config.client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  config.ref = ENV['GITHUB_SHA']
  config.repo = ENV['GITHUB_REPOSITORY']
  config.workspace = ENV['GITHUB_WORKSPACE'] #  a copy of your repository if your workflow uses the actions/checkout action
  config.pr_id = pull_request_nr.to_i
end

MainAppService.new.call
