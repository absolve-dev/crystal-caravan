class UsersController < ApplicationController
  def my_account
    authenticate_user!
    @orders = Order.where(:email => current_user.email)
  end
end