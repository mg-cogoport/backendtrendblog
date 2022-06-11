class Role < ApplicationRecord 
    


    has_many(
    :users,
    class_name: 'User',
    foreign_key: 'user_id',
    inverse_of: :role,
    dependent: :destroy
)
end
