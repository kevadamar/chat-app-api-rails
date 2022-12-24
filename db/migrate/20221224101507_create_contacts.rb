class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.integer :owner_id
      t.integer :owner_contact_id

      t.timestamps
    end
  end
end
