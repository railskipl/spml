class AddUserIdToTeamUsers < ActiveRecord::Migration
  def change
    add_column :team_users, :user_id, :integer
  end
end
