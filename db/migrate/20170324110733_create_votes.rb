class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.boolean :yay
      t.boolean :nay
      t.references :votable, polymorphic: true, index: true
      t.references :voter

      t.timestamps
    end
  end
end
