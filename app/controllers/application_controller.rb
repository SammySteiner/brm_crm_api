class ApplicationController < ActionController::API

  private

  def authorize_user!
      if !current_user.present?
        render json: {error: 'Authorization invalid'}, status: 404
      end
  end

  def current_user
    decoded = decode(token)
    if decoded.present?
      @current_user ||= User.find(decoded.first['user_id'])
    end
  end

  def decode(token)
    JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: ENV['JWT_ALGORITHM']})
    rescue JWT::DecodeError
      return nil
  end

  def token
    request.headers['Authorization']
  end
end
