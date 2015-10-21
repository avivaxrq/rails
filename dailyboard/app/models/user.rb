class User < ActiveRecord::Base
	has_secure_password
	before_create {generate_token(:token)}

	has_many :task_boards

	validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
	validates :password, :length => {:minimum => 6}, :on => :create

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
end
