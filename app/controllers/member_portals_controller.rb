# frozen_string_literal: true

# Controller: MemberPortalsController
# Purpose:
# - Provide a controller for the MemberPortal model
# - This controller handles the functionality of the MemberPortal portion of the application.
# File Location:
# - app/controllers/member_portals_controller.rb
# Tests Location:
# - test/controllers/member_portals_controller_test.rb
class MemberPortalsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show; end
end
