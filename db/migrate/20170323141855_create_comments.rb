class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.datetime :added_at
      t.references :commentable, polymorphic: true, index: true
      t.references :author

      t.timestamps
    end
  end
end
