class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :cid
      t.string :cname

      t.timestamps
    end
  end
end
