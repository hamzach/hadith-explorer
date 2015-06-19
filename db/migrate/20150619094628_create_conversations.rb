class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :starter
      t.integer :target

      t.timestamps
    end
  end
end