# frozen_string_literal: true

class HardJob
  include Sidekiq::Job

  def perform(name, age)
    # Do something
  end
end
# HardJob.perform_async('bob', 5)
