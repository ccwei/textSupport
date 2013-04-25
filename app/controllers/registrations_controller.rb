require './ModRest.rb'

class RegistrationsController < Devise::RegistrationsController
  def register_XMPP_user(username, password)
   logger.info 'create user:' + username
    register_str = 'register ' + username + ' ' + DOMAINNAME + ' ' +  password
    response = send_ctl_command(register_str)
  end

  def create
      logger.info '=================create==============='
      params[:member][:email] = params[:member][:email].strip if params[:member] and params[:member][:email]
      build_resource
      email = params[:member][:email]
      member = Member.find_by_email(email)
      if member.present?
        xmpp_username = member.id.to_s
        xmpp_password = params[:member][:password]
      end
      if resource.save
        member = Member.find_by_email(email)
        xmpp_username = member.id.to_s
        xmpp_password = params[:member][:password]
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          register_XMPP_user(xmpp_username, xmpp_password)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
        end
      else
        clean_up_passwords resource
      end
      if member.present?
        render :json => {:isListener => member.is_listener, :uid => member.id}.to_json()
      else
        render :json => {:isListener => 0}.to_json()
      end
  end

end
