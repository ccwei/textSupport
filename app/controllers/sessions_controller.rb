class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in)
    sign_in(resource_name, resource)
    respond_with resource, :location => root_url
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end

end

