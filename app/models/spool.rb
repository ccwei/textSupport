class Spool < ActiveRecord::Base
  self.table_name = 'spool'
  self.primary_key = 'seq'
end
