class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :sender_id
      t.text :message_text

      t.timestamps
    end
  end
end
