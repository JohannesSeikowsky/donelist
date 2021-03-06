class User < ActiveRecord::Base

  has_many :dones

  before_save :passing_and_salting
  attr_accessor :password

  validates_confirmation_of :password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  def passing_and_salting
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def user_authentication(pass)
    if self.password_hash == BCrypt::Engine.hash_secret(pass, self.password_salt)
      true
    else
      nil
    end
  end

end