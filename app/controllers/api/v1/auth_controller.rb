class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(email: params['email'])
    staff = Staff.find_by(email: params['email'])
    if user.present? && user.authenticate(params['password'])
      token = JWT.encode({user_id: user.id}, ENV["JWT_SECRET"], ENV["JWT_ALGORITHM"])
      render json: {user_id: user.id, staff_id: staff.id, token: token}
    else
      render json: {error: "No account or password found."}
    end
  end

end
