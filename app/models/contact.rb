class Contact < ApplicationRecord

    belongs_to :user, optional: true

    has_one :my_contact, class_name: 'User', foreign_key: :id, primary_key: 'owner_contact_id'

    has_many :messages
end
