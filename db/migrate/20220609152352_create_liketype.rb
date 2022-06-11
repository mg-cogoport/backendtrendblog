class CreateLiketype < ActiveRecord::Migration[7.0]
  def change
    create_table :liketypes do |t|
      t.integer :liketype
      t.timestamps
    end
  end
end
