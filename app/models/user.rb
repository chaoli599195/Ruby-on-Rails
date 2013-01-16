class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true

  validate :password_must_be_present

  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.password == password
        user
        end
      end
  end

  private
  def password_must_be_present
    errors.add(:password, "Missing password") unless password.present?
  end

end
