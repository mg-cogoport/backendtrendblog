class Post < ApplicationRecord 
    validates :title, presence: true, length: {minimum:3}
    validates :content, presence: true, length: {minimum:3}
    validates :publish_date, presence: true
    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        inverse_of: :posts
      )
    #   belongs_to(
    #     :tag,
    #     class_name: 'Tag',
    #     foreign_key: 'tag_id',
    #     inverse_of: :posts
    #   )
        has_many :likes, dependent: :destroy
        has_many :users, through: :likes

        has_many :comments, dependent: :destroy
        has_many :users, through: :comments

        has_many :posttags, dependent: :destroy
        has_many :tags, through: :posttags
end
