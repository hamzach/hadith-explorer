class CreateHadithCategories < ActiveRecord::Migration
  def change
    create_table :hadith_categories do |t|
      t.string :cid
      t.string :hid

      t.timestamps
    end
  end
end
