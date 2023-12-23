# frozen_string_literal: true

# Controller: AdminPortalsController
# Purpose:
# - Provide a controller for the AdminPortal model
# - This controller handles the functionality of the AdminPortal portion of the application.
# File Location:
# - app/controllers/admin_portals_controller.rb
# Tests Location:
# - test/controllers/admin_portals_controller_test.rb
class AdminPortalsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show; end
end
