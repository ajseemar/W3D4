class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :author_id, null: false
      t.timestamps
    end
  end
end
