namespace :TS do
  task :send_apns => :environment do
    Spool.all.group_by(&:username).each do |userid, msgs|
      m = Member.find(userid)
      APNS.pem  = "#{Rails.root}/lib/tasks/APNCert.pem"
      if m.device_token.present?
        APNS.send_notification(m.device_token, :alert => 'New Message Received!', :badge => 1, :sound => 'default')
      end
      puts userid + ":" + msgs.count.to_s
    end
  end
  task :sleep_send_apns => :environment do
    sleep(30)
    Spool.all.group_by(&:username).each do |userid, msgs|
      m = Member.find(userid)
      APNS.pem  = "#{Rails.root}/lib/tasks/APNCert.pem"
      if m.device_token.present?
        APNS.send_notification(m.device_token, :alert => 'New Message Received!', :badge => 1, :sound => 'default')
      end
      puts userid + ":" + msgs.count.to_s
    end
  end
end
