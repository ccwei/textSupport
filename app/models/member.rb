class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname, :gender,\
                  :occupation, :description, :device_token, :enable_notdisturb
  scope :listeners, where(:is_listener => true)

  def jid
    id.to_s
  end

  def start_at
    split = self.notdisturb.('-', 2)
    split.first
  end

  def start_at=(start_at)

  end



end
