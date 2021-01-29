# frozen_string_literal: true

class RubocopOffense
  attr_accessor :start_line, :end_line, :severity, :message

  def initialize(offense_hash)
    location = offense_hash['location']
    @start_line = location['start_line']
    @end_line = location['end_line']
    @severity = offense_hash['severity']
    @message = offense_hash['message']
  end
end
