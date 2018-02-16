class Api::V1::UserController < ApplicationController

  def index
    all_users = Staff.select(:id, :email)
    registered_users = User.select(:id, :email)
    render json: {
      all_users: all_users,
      registered_users: registered_users
    }
  end

  def create
    user = User.create(user_params)
    staff = Staff.find_by(email: user_params['email'])
    token = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
    render json: {
      user_id: user.id,
      staff_id: staff.id,
      token: token
    }
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :email)
  end


end
