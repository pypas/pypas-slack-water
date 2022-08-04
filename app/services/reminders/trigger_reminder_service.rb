
module Reminders
  class TriggerReminderService
    DEFAULT_MESSAGE = "Hey, you should drink some water!"

    def initialize(message:)
      @message = message ||= DEFAULT_MESSAGE
      url = "https://slack.com/api/chat.postMessage"
      HTTParty.post(url, body: body.to_json, headers: headers)
    end

    private

    attr_reader :trigger_id, :message

    def text
      "*Water Reminder*\n\n" + message
    end

    def headers
      {
        "Authorization": "Bearer #{token}",
        "Content-Type": "application/json"
      }
    end

    def body
      {
        "channel": channel_id,
        "blocks": [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": text
            },
            "accessory": {
              "type": "image",
              "image_url": "https://images.unsplash.com/photo-1555704574-a9cfdfab06e0?ixlib=rb-.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80",
              "alt_text": "Water image"
            }
          }
        ]
      }
    end

    def token
      Rails.application.credentials.slack[:token]
    end

    def channel_id
      Rails.application.credentials.slack[:channel_id]
    end

  end
end