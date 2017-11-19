class User < ApplicationRecord
	has_secure_password
  has_secure_token :auth_token
  has_many :movies

  before_validation :downcase_email

  validates :password_confirmation, presence: true, on: :create
  validates :password, confirmation: true, presence: true, on: :create

  validates :email,
  presence: true,
  uniqueness: true,
  format: {
  	with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/,
  	message: "Invalid email address"
  }

  validates :name, presence: true

  def json_hash
  	{
  		:name => self.name,
  		:email => self.email,
  		:token => self.auth_token,
  		:id => self.id
  	}
end

private

def downcase_email
	self.email = email.downcase if email.present?
end

end
