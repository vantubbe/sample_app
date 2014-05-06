class CreateUserPosts < ActiveRecord::Migration
  def change
    create_table :user_posts do |t|
      t.integer :user_id
      t.string :message

      t.timestamps
    end
    add_index :user_posts, :user_id
  end
end
