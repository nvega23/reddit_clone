class CreatePostSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :post_subs do |t|
      t.references :post, foreign_key: {to_table: :posts}
      t.references :sub, foreign_key: {to_table: :subs}
      t.timestamps
    end
  end
end
