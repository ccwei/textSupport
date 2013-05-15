require './ModRest.rb'

class RegistrationsController < Devise::RegistrationsController
  def register_XMPP_user(username, password)
   logger.info 'create user:' + username
    register_str = 'register ' + username + ' ' + DOMAINNAME + ' ' +  password
    response = send_ctl_command(register_str)
  end

  #GET /resource/edit
  def edit
    render :template => 'members/registrations/edit'
  end

  def update
    super
  end

  def create
    logger.info '=================create==============='
    params[:member][:email] = params[:member][:email].strip if params[:member] and params[:member][:email]
    build_resource
    email = params[:member][:email]
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)

        member = Member.find_by_email(email)
        if member.present?
          xmpp_username = member.id.to_s
          xmpp_password = params[:member][:password]
        end
        register_XMPP_user(xmpp_username, xmpp_password)
        respond_with resource do |format|
          format.json {render :json => resource}
          format.html {redirect_to after_sign_up_path_for(resource)}
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource do |format|
          format.json {render :json => resource}
          format.html {redirect_to after_inactive_sign_up_path_for(resource)}
        end
      end
    else
      clean_up_passwords resource
      respond_with resource do |format|
        format.json {render :json => resource}
        format.html {redirect_to root_url}
      end
    end
  end


end
