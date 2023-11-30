# frozen_string_literal: true

# Model: Current
# Purpose:
# - Provide a model for the Current model
# - This model handles the functionality of the Current portion of the application.
# File Location:
# - app/models/current.rb
# Tests Location:
# - test/models/current_test.rb
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
