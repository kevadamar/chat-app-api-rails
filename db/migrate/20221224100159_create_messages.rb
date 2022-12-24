class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :from_user
      t.integer :to_user
      t.text :message_text
      t.datetime :sent_datetime
      t.integer :contact_id

      t.timestamps
    end
  end
end
