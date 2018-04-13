class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :blogs, [:user_id, :created_at]
  end
end
