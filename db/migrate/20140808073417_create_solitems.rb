class CreateSolitems < ActiveRecord::Migration
  def change
    create_table :solitems do |t|
      t.references :req, index: true
      t.references :user, index: true
      t.string :sphase
      t.string :starget
      t.string :stitle
      t.text :scontent
      t.integer :slevel
      t.text :saction
      t.string :snote
      t.text :snotedetail

      t.timestamps
    end
  end
end
