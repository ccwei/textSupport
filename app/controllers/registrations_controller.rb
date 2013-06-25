require './ModRest.rb'

class RegistrationsController < Devise::RegistrationsController
  def register_XMPP_user(username, password)
   logger.info 'create user:' + username
    register_str = 'register ' + username + ' ' + DOMAINNAME + ' ' +  password
    response = send_ctl_command(register_str)
  end

  #GET /resource/edit
  def edit
    @notdisturb = resource.notdisturb
    @notdisturb = @notdisturb.split(" ")

    logger.debug @notdisturb.inspect
    render :template => 'members/registrations/edit'
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    logger.debug self.resource.inspect
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    logger.debug "============params = " + params.inspect

    if resource.update_with_password(resource_params)
      resource.notdisturb = params["notdisturb_from"] + " " + params["from_ampm"] + " " + params["notdisturb_to"] + " " + params["to_ampm"]
      resource.save
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update_device_token
    if params[:email].present? and params[:device_token].present?
      member = Member.find_by_email(params[:email])
      member.device_token = params[:device_token]
      member.save
    end
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
