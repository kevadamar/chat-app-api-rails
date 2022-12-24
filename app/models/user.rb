class User < ApplicationRecord
    has_secure_password

    has_many :contacts, foreign_key: 'owner_id', primary_key: :id

    belongs_to :usr_contact, class_name: 'Contact', foreign_key: :id, primary_key: 'owner_contact_id'

    # has_many :my_contacts, class_name: 'Contact', foreign_key: 'owner_contact_id', primary_key: :id

    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }
end
