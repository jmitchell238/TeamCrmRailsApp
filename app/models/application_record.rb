# frozen_string_literal: true

# Model: ApplicationRecord
# Purpose:
# - Provide a model for the Application model
# - This model handles the functionality of the Application portion of the application.
# File Location:
# - app/models/application_record.rb
# Tests Location:
# - test/models/application_record_test.rb
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
