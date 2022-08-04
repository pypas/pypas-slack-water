module Reminders
  class CreateReminderService
    def initialize(trigger_id)
      @trigger_id = trigger_id
    end

    def call
      url = "https://slack.com/api/views.open"
      HTTParty.post(url, body: body.to_json, headers: headers)
    end

    private

    attr_reader :trigger_id

    def headers
      {
        "Authorization": "Bearer #{token}",
        "Content-Type": "application/json"
      }
    end

    def body
      BodyBuilder.new(trigger_id).body
    end


    def token
      Rails.application.credentials.slack[:token]
    end
  end
end