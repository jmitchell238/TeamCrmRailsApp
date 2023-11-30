# frozen_string_literal: true

# Controller: MainController
# Purpose:
# - Provide a controller for the Main model
# - This controller handles the functionality of the Main portion of the application.
# File Location:
# - app/controllers/main_controller.rb
# Tests Location:
# - test/controllers/main_controller_test.rb
class MainController < ApplicationController
  def index
    # @users = User.all
  end
end

# ```
# And then in your view, you can do something like this:
# ```
# Path: app/views/main/index.html.erb
# <% @users.each do |user| %>
# <%= user.name %>
# <% end %>
# ```
# This is a very basic example, but it should get you started.  I would recommend reading through the Rails Guides
# to get a better understanding of how Rails works.
