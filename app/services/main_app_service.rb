# frozen_string_literal: true

require 'active_support/configurable'
require_relative './rubocop_service'
require_relative '../models/pull_request_commenter'

class MainAppService
  include ActiveSupport::Configurable
  config_accessor :client, :ref, :repo, :owner, :workspace, :pr_id

  def call
    RubocopService.config.workspace = workspace
    rubocop = RubocopService.new
    results = rubocop.call

    commenter = PullRequestCommenter.new(client, repo, pr_id, ref)
    rubocop.annotations&.each do |annotation|
      commenter.comment(annotation)
    end

    conclusion = results['conclusion']
    output = results['output']
  rescue StandardError => e
    puts e.message
    exit(false)
  end
end
