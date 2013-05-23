class CreateSpools < ActiveRecord::Migration
  def change
    create_table :spools do |t|

      t.timestamps
    end
  end
end
