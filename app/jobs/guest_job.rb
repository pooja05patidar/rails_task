# frozen_string_literal: true

class GuestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
