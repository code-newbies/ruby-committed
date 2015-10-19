class CreateAchievementsUsersJoin < ActiveRecord::Migration
  def change
    create_table :achievements_users, id: false do |t|
      t.column 'achievement_id', :integer
      t.column 'user_id',        :integer
    end
  end
end
