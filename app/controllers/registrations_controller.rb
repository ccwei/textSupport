require 'xmpp4r'

class RegistrationsController < Devise::RegistrationsController
  def register_XMPP_user(username, password)
    jid = Jabber::JID.new('chat@localhost')
    client = Jabber::Client.new(jid)
    client.connect
    client.auth("123456")

    #iqr = Iq.new(:set)
    #qr = IqQuery.new
    #qr.add_namespace('jabber:iq:register')
    #qr.add(REXML::Element.new('username').add_text(username))
    #qr.add(REXML::Element.new('password').add_text(password))
    #iqr.add(qr)
    #client.send iqr
  end

  def create
      params[:user][:email] = params[:user][:email].strip if params[:user] and params[:user][:email]
      build_resource
      logger.info '=================resource==========' + params[:user][:password]
      register_XMPP_user params[:user][:email], params[:user][:password]
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
  end
end
