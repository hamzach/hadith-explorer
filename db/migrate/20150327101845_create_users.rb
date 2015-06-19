class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.integer :verified

      t.timestamps
    end
  end
end
