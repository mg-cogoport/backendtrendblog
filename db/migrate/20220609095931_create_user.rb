class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile 
      t.string :email
      t.string :password
      t.text :intro
      t.string :image
      t.integer :status
      t.timestamps
    end
  end
end
