class AddTitleToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :title, :string
  end
end
