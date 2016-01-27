class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uname
      t.string :upass
      t.string :uemail
      t.string :unote
      t.text :unotedetail

      t.timestamps
    end
  end
end
