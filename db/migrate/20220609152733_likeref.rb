class Likeref < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :liketype, foreign_key: true

  end
end
