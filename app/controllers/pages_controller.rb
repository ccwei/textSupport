class PagesController < ActionController::Base
	before_filter :authenticate_user!, :only => [:login]
	#ssl_required :login # you have to set up ssl and ssl_requirement

	def login
	  @user = current_user
	  respond_to do |format|
	    format.html {render :text => "#{@user.id}"}
	    #format.xml {render :text => "#{@user.id}" }
	    format.json {render :json => "#{@user.id}"}
	  end
	end
end
