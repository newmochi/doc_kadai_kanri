class ModifySolitems1 < ActiveRecord::Migration
  def change
    add_column :solitems, :sduedate, :date
  end
end
