require './ModRest.rb'

class ChatusersController < ActionController::Base
  def random_user
    offset = rand(Member.listeners.count)
    rand_member = Member.find(10)
    #rand_member = Member.listeners.first(:offset => offset)
    #render :json => rand_member.jid.to_json()
    return rand_member.jid
  end

  def add_rosteritem user1, user2
    add_rosteritem_str = 'add_rosteritem ' + user1 + ' ' + DOMAINNAME + ' ' +  user2 + ' ' + DOMAINNAME + ' ' + user2 + ' Buddies both'
    response = send_ctl_command(add_rosteritem_str)
  end

  def chat_random_user
    user1 = params[:user]
    user2 = random_user
    add_rosteritem user1, user2
    render :json => {:listenerJid => user2 + '@' + DOMAINNAME}.to_json()
  end
end
