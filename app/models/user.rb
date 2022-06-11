class User < ApplicationRecord 
    # belongs_to :roles
    has_secure_password
    validates :first_name, presence: true, length: {minimum:3, maximum:10}
    validates :last_name, presence: true, length: {minimum:3, maximum:10}
    validates :mobile, presence: true, length: {minimum:10, maximum:15}
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
    # validates :password, presence: true
    PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x
    # validates :password, :presence => true,
    # :confirmation => true,
    # :length => {:within => 6..40},
    # format: { with: PASSWORD_FORMAT }, 
    # :on => :create
    belongs_to(
        :role,
        class_name: 'Role',
        foreign_key: 'role_id',
        inverse_of: :users
      )
      has_many(
        :posts,
        class_name: 'Post',
        foreign_key: 'user_id',
        inverse_of: :user,
        dependent: :destroy
      )
      has_many :likes, dependent: :destroy
      has_many :posts, through: :likes


      has_many :comments, dependent: :destroy
      has_many :posts, through: :comments

      
end
