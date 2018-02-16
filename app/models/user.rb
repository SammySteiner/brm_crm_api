class User < ApplicationRecord
  has_secure_password

  def staff
    Staff.find_by(email: self.email)
  end
end
