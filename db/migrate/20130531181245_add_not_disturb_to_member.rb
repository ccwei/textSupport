class AddNotDisturbToMember < ActiveRecord::Migration
  def change
    add_column :members, :notdisturb, :string
  end
end
