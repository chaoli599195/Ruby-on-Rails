class Admin < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :password, :confirmation => true

  validate :password_must_be_present
end
