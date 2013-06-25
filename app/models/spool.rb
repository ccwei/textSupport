class Spool < ActiveRecord::Base
  self.table_name = 'spool'
  self.primary_key = 'seq'

  scope :not_notified, where(:notified => false)
  def self.sendAPNs
    Spool.not_notified.group_by(&:username).each do |userid, msgs|
      m = Member.find(userid)
      APNS.pem  = "#{Rails.root}/lib/tasks/APNCert.pem"
      if m.device_token.present?
        APNS.send_notification(m.device_token, :alert => 'New Message Received!', :badge => msgs.count, :sound => 'default')
      end
      msgs.each do |m|
        m.notified = true
        m.save
      end
      puts userid + ":" + msgs.count.to_s
    end
  end
end
