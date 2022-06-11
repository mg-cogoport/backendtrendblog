class CreateTag < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :title
      t.integer :status
      t.timestamps
    end
  end
end
