namespace :TS do
  task :send_apns => :environment do
    Spool.sendAPNs
  end
  task :sleep_send_apns => :environment do
    sleep(30)
    Spool.sendAPNs
  end
end
