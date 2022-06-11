class CreatePost < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
        t.integer :parent_id
        t.string :title
        t.text :content
        t.string :image
        t.date :publish_date
        t.integer :status
      t.timestamps
    end
  end
end
