class AddDeviceTokenToMember < ActiveRecord::Migration
  def change
    add_column :members, :device_token, :string
  end
end
