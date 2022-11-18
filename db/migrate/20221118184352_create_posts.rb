class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.references :sub, foreign_key: {to_table: :subs}
      t.references :author, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
