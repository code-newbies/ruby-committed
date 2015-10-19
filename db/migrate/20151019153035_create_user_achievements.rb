class CreateUserAchievements < ActiveRecord::Migration
  def change
    create_table :user_achievements do |t|
      t.integer :achievement_id
      t.integer :user_id
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
