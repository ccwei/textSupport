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

  def about
    render 'about', :layout => 'application'
  end

  def info
    render 'info', :layout => 'application'
  end

  def privacy
    render 'privacy', :layout => 'application'
  end

  def terms
    render 'terms', :layout => 'application'
  end

  def contacts
    render 'contacts', :layout => 'application'
  end

  def user_list
    @member = Member.where("created_at > :date", date: "2013-05-18 00:00:00")
    @users = BetaEmail.where("created_at > :date", date: "2013-05-18 00:00:00")
    render 'user_list', :layout => 'application'
  end

  def one_minute
    render 'one_minute', :layout => 'application'
  end

end
