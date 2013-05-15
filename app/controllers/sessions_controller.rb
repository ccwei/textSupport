class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    #logger.info 'accept' + request.inspect
    logger.info '------'
    resource = warden.authenticate!(auth_options)
    logger.info resource.inspect
    set_flash_message(:notice, :signed_in)
    sign_in(resource_name, resource)
    respond_with(resource) do |format|
      format.json {render :json => resource}
      format.html {redirect_to root_url}
    end
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end

end

