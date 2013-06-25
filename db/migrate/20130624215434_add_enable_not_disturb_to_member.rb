class AddEnableNotDisturbToMember < ActiveRecord::Migration
  def change
    add_column :members, :enable_notdisturb, :string
  end
end
