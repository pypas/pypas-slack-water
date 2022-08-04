module Reminders
  class BodyBuilder
    def initialize(trigger_id)
      @trigger_id = trigger_id
    end

    def body
      {
        "trigger_id": trigger_id,
        "view": {
          "type": "modal",
          "callback_id": "modal-identifier",
          "title": {
            "type": "plain_text",
            "text": "Drink Water Reminder",
            "emoji": true
          },
          "submit": {
            "type": "plain_text",
            "text": "Submit",
            "emoji": true
          },
          "close": {
            "type": "plain_text",
            "text": "Cancel",
            "emoji": true
          },
            "blocks": [
              start_time_block,
              end_time_block,
              time_interval_block,
              message_block
            ]
        }
      }
    end

    private

    attr_reader :trigger_id

    def start_time_block
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "Select a start time"
        },
        "accessory": {
          "type": "timepicker",
          "initial_time": "15:00",
          "placeholder": {
            "type": "plain_text",
            "text": "Select time",
            "emoji": true
          },
          "action_id": "start_time"
        },
        "block_id": "start_time"
      }
    end
  
    def end_time_block
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "Select an end time"
        },
        "accessory": {
          "type": "timepicker",
          "initial_time": "20:00",
          "placeholder": {
            "type": "plain_text",
            "text": "Select time",
            "emoji": true
          },
          "action_id": "end_time"
        },
        "block_id": "end_time"
      }
    end
  
    def time_interval_block
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "Select a time interval"
        },
        "accessory": {
          "type": "static_select",
          "placeholder": {
            "type": "plain_text",
            "text": "Select an item",
            "emoji": true
          },
          "initial_option": {
            "text": {
              "type": "plain_text",
              "text": "30 minutes",
              "emoji": true
            },
            "value": "0.5"
          },
          "options": [
            {
              "text": {
                "type": "plain_text",
                "text": "15 minutes",
                "emoji": true
              },
              "value": "0.25"
            },
            {
              "text": {
                "type": "plain_text",
                "text": "30 minutes",
                "emoji": true
              },
              "value": "0.5"
            },
            {
              "text": {
                "type": "plain_text",
                "text": "1 hour",
                "emoji": true
              },
              "value": "1"
            }
          ],
          "action_id": "time_interval"
        },
        "block_id": "time_interval"
      }
    end

    def message_block
      {
        "type": "input",
        'optional': true,
        "element": {
          "type": "plain_text_input",
          "action_id": "message"
        },
        "label": {
          "type": "plain_text",
          "text": "Message",
          "emoji": true
        },
        "block_id": "message"
      }
    end
  end
end