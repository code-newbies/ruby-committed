class AddIndexToUserAchievements < ActiveRecord::Migration
  def change
    add_index :user_achievements, [:user_id, :achievement_id], unique: true
  end
end
