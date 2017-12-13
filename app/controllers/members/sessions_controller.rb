class Members::SessionsController < Devise::SessionsController

	def new
		super do |resource|
			resource.build_profile_member
		end
	end
	protected
		def after_sign_in_path_for(resource)
			site_profile_dashboard_index_path
		end
end