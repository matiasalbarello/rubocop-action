# frozen_string_literal: true

require 'active_support/configurable'
require_relative '../models/rubocop_offense'
require 'json'

class RubocopService
  include ActiveSupport::Configurable
  config_accessor :workspace
  attr_accessor :conclusion, :count, :annotations

  def call
    Dir.chdir(workspace) do
      parse_errors(`rubocop --format json`)
    end
    p annotations # debug
    parsed_output
  rescue StandardError => e
    puts e.message
    exit(false)
  end

  private

  def annotation_level(annotation)
    return 'failure' unless annotation == 'warning'

    annotation
  end

  def parsed_output
    output = {
      title: 'Rubocop',
      summary: "#{count} offense(s) found",
      annotations: annotations
    }

    { output: output, conclusion: conclusion }
  end

  def parse_errors(json_stream)
    errors = JSON.parse(json_stream)
    errors['files'].each do |file|
      path = file['path']
      offenses = file['offenses'].map{ |offense_hash| RubocopOffense.new(offense_hash) }
      count = offenses.count
      @annotations = offenses.map do |offense|
        annotation_level = annotation_level(offense.severity)
        conclusion = annotation_level == 'failure' ? 'failure' : 'success'

        {
          path: path,
          start_line: offense.start_line,
          end_line: offense.end_line,
          annotation_level: annotation_level,
          message: offense.message
        }
      end
    end
  end
end
