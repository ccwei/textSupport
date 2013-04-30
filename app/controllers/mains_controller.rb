class MainsController < ActionController::Base
	def main
		render 'main', :layout => 'cosmo'
	end
end
