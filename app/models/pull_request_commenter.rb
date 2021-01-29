# frozen_string_literal: true

class PullRequestCommenter
  attr_accessor :client, :repo, :pr_id, :ref

  def initialize(client, repo, pr_id, ref)
    @client = client
    @repo = repo
    @pr_id = pr_id
    @ref = ref
  end

  def comment(rubocop_annotation)
    @client.create_pull_request_comment(
      repo,
      pr_id,
      rubocop_annotation[:message],
      ref,
      rubocop_annotation[:path],
      rubocop_annotation[:start_line]
    )
  end
end
