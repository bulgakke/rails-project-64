class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      t.text :content, null: false


      t.string :ancestry, null: false
      t.index :ancestry

      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
