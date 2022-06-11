class Tag < ApplicationRecord 
#     has_many(
#     :posts,
#     class_name: 'Post',
#     foreign_key: 'post_id',
#     inverse_of: :tag,
#     dependent: :destroy
# )
        has_many :posttags, dependent: :destroy
      has_many :posts, through: :posttags
end
