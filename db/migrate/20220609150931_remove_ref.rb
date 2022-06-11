class RemoveRef < ActiveRecord::Migration[7.0]
  def change
    remove_reference :posts, :tag, foreign_key: true
  end
end
