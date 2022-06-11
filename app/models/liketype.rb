class Liketype < ApplicationRecord 
    has_many(
        :likes,
        class_name: 'Like',
        foreign_key: 'like_id',
        inverse_of: :liketype,
        dependent: :destroy
    )
end
    