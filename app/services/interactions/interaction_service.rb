module Interactions
  class InteractionService
    def initialize(payload)
      @payload = payload
    end

    def call
      if (payload["type"] == "view_submission")
        @state = payload.dig("view","state","values")
        set_reminders
      end
    end

    def set_reminders
      (start_time.to_i .. end_time.to_i).step(time_interval.hour) do |date|
        if Time.at(date) > Time.now()
          interval = Time.at(date) - Time.now()
          ReminderWorker.perform_at(interval.seconds.from_now, message)
        end
      end
    end
    
    private

    attr_reader :payload, :state

    def message
      state.dig("message", "message", "value")
    end

    def start_time
      state.dig("start_time","start_time","selected_time").to_time
    end

    def end_time
      state.dig("end_time","end_time","selected_time").to_time
    end

    def time_interval
      state.dig("time_interval","time_interval","selected_option","value").to_f || 1.0
    end
  end
end