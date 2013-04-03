require './ModRest.rb'

class ChatusersController < ActionController::Base
  def random_user
    offset = rand(Member.count)
    rand_member = Member.first(:offset => offset)
    render :json => rand_member.jid.to_json() 
  end
end
