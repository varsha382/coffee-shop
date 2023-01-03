class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :password
  validates :email,
    format: {with: /^(.+)@(.+)$/, message: "Email invalid", :multiline => true  },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 254 }
  # validates_confirmation_of :password

  has_many :orders
end
