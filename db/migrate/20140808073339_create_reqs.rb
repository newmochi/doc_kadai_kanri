class CreateReqs < ActiveRecord::Migration
  def change
    create_table :reqs do |t|
      t.references :user, index: true
      t.integer :rchap
      t.integer :rsec
      t.integer :rsubsec
      t.integer :rseqno
      t.string :rtitile
      t.text :rcontent
      t.string :rnote
      t.text :rnotedetail

      t.timestamps
    end
  end
end
