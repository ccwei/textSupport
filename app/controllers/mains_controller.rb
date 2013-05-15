class MainsController < ActionController::Base
	def main
		render 'main', :layout => 'application'
	end
end
