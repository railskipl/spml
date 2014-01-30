class CreateBthirties < ActiveRecord::Migration
  def change
    create_table :bthirties do |t|
      t.integer :count

      t.timestamps
    end
  end
end
