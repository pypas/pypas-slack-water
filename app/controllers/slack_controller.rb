class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reminder
    trigger_id = params.fetch("trigger_id")
    Reminders::CreateReminderService.new(trigger_id).call

    render plain: "Water Reminder Set"
  end

  def interaction
    payload = JSON.parse(params.fetch("payload"))
    Interactions::InteractionService.new(payload).call

    render status: 200, json: {}
  end
end