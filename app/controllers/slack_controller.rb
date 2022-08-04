class SlackController < ApplicationController
  def reminder
    trigger_id = params.fetch("trigger_id")
    Reminders::CreateReminderService.new(trigger_id).call

    render plain: "Water Reminder Set"
  end
end