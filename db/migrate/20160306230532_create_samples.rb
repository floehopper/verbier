class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.belongs_to :piste, index: true, foreign_key: true
      t.integer :state
      t.timestamps
    end
  end
end
