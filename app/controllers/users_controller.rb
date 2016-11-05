class UsersController < ApplicationController
	def bind
    @user = User.new
  end
end