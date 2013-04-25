require 'rest-client'

DOMAINNAME = 'text-support.org'
ADMIN_ACCOUNT = 'admin'
ADMIN_PASSWORD = '123456'

def send_ctl_command(command)
  server_str = 'http://' + DOMAINNAME + ':5285/rest/'
  auth_str = '--auth ' + ADMIN_ACCOUNT + ' ' + DOMAINNAME + ' ' + ADMIN_PASSWORD + ' ' 
  response = RestClient.post(server_str, auth_str + command)
end 
