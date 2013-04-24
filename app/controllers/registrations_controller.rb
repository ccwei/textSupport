require './ModRest.rb'

class RegistrationsController < Devise::RegistrationsController
  def register_XMPP_user(username, password)
    register_str = 'register ' + username + ' ' + DOMAINNAME + ' ' +  password
    response = send_ctl_command(register_str)
  end

  def create
      params[:member][:email] = params[:member][:email].strip if params[:member] and params[:member][:email]
      build_resource
      email = params[:member][:email]
      member = Member.find_by_email(email)
      xmpp_username = params[:member][:email].gsub('@', '_')
      xmpp_password = params[:member][:password]
      logger.info '=================resource==========' + params[:member][:password]
      register_XMPP_user params[:member][:email], params[:member][:password]
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          register_XMPP_user(xmpp_username, xmpp_password)
          if member.present?
		logger.info "1============" +  member.is_listener.to_s
          	render :json => {:isListener => member.is_listener}.to_json()
          else
          	render :json => {:isListener => 0}.to_json()	
	  end
	  #respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          if member.present?
		logger.info "2============" + member.is_listener.to_s
          	render :json => {:isListener => member.is_listener}.to_json()
          else
          	render :json => {:isListener => 0}.to_json()	
	  end
          #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
          if member.present?
		logger.info "3============" +  member.is_listener.to_s
          	render :json => {:isListener => member.is_listener}.to_json()
          else
          	render :json => {:isListener => 0}.to_json()	
	  end
        #respond_with resource
      end
  end
end
