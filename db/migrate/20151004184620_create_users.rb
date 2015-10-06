class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :email, null: false, index: :unique
      t.string     :password_digest, null: false
      t.string     :verification_token
      t.datetime   :verified_at
      t.string     :password_reset_token
      t.timestamps null: false
    end
  end
end
