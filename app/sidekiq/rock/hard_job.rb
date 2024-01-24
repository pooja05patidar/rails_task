# frozen_string_literal: true

module Rock
  class HardJob
    include Sidekiq::Job

    def perform(*args)
      # Do something
    end
  end
end
