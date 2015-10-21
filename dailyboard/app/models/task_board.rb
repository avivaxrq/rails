class TaskBoard < ActiveRecord::Base
	belongs_to :user

	def get_user_name
		# user_id = this.user_id
		puts "here"
		name = User.find(user_id).name
		puts name
		return name
	end
end
