class Like < ApplicationRecord 
    belongs_to :user
    belongs_to :post
    belongs_to(
        :liketype,
        class_name: 'Liketype',
        foreign_key: 'liketype_id',
        inverse_of: :likes
      )
end
