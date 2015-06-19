class FixColumnNameInUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :type, :usertype
  end
end
