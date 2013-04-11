class AddListenerToMember < ActiveRecord::Migration
  def change
    add_column :members, :is_listener, :boolean, :default => 0
  end
end
