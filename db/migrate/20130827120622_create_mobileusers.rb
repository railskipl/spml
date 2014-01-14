class CreateMobileusers < ActiveRecord::Migration
  def change
    create_table :mobileusers do |t|
      t.integer :user_id
      t.string  :imei
      t.timestamps
    end
  end
end
