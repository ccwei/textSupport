class AddInfoToMember < ActiveRecord::Migration
  def change
    add_column :members, :gender, :string
    add_column :members, :occupation, :string
    add_column :members, :description, :string
  end
end
