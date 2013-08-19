class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :encrypted_password
      t.string :salt
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.boolean :is_admin, :default=>false

      t.timestamps
    end
  end
end
