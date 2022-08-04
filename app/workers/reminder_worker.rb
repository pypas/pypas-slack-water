class ReminderWorker
  include Sidekiq::Worker

  def perform(message)
    Reminders::TriggerReminderService.new(message: message)
  end
end