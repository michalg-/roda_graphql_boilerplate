# frozen_string_literal: true
module RequestSupport
  def json_response
    JSON.parse(subject.body)
  end
end
