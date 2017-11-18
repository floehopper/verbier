class AddGradeToPistes < ActiveRecord::Migration
  def change
    add_column :pistes, :grade, :string
  end
end
