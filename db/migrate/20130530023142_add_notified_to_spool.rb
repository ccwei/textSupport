class AddNotifiedToSpool < ActiveRecord::Migration
  def change
    add_column :spool, :notified, :boolean, :default => false
  end
end
