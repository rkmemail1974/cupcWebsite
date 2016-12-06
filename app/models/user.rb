# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base

	attr_accessible :name, :email, :password, :password_confirmation
	
	validates :name, presence: true, length: { maximum: 50 }
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z/d/-.]+\.[a-z]+_\z/i
	validates :email, presence: true, #format: {with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }

		before_save { |user| user.email = email.downcase }
		before_save :create_remember_token

		validates :password, presence: true, length: { minimum: 8 }
		validates :password_confirmation, presence: true


private 
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
