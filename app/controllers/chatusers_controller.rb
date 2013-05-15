require './ModRest.rb'

class ChatusersController < ActionController::Base
  def random_user
    offset = rand(Member.listeners.count)
    #rand_member = Member.find(43)
    rand_member = Member.listeners.first(:offset => offset)
    #render :json => rand_member.jid.to_json()
    return rand_member
  end

  #user1 is jid, user2 is Member
  def add_rosteritem user1, user2
    add_rosteritem_str = 'add_rosteritem ' + user1 + ' ' + DOMAINNAME + ' ' +  user2.jid + ' ' + DOMAINNAME + ' ' + user2.nickname + ' Buddies both'
    response = send_ctl_command(add_rosteritem_str)
  end

  def chat_random_user
    user1 = params[:user]
    user2 = random_user
    add_rosteritem user1, user2
    listenerJID = user2.jid + '@' + DOMAINNAME
    user1JID = user1 + '@' + DOMAINNAME
    #send_default_msg listenerJID, user1JID
    render :json => {:listenerJid => listenerJID, :nickname => user2.nickname, :desc => user2.description, :gender => user2.gender}.to_json()
  end

  def get_nick_name
    jid = params[:jid]
    id = jid[0...jid.index('@')].to_i
    logger.info id.to_s
    member = Member.find_by_id(id)
    if member.is_listener
      render :json => {:nickname => member.nickname}.to_json()
    else
      render :json => {:nickname => 'User #' + id.to_s}.to_json()
    end
  end

  def send_default_msg from, to
    body = "\"Hi! Is there something you would like to talk about today?\""
    send_message_chat = 'send_message_chat ' + from + ' '+  to + ' ' + body
    logger.info send_message_chat
    response = send_ctl_command(send_message_chat)
  end
end
