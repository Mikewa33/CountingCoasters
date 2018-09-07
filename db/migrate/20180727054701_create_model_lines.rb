class CreateModelLines < ActiveRecord::Migration[5.1]
  def change
    create_table :model_lines do |t|
      t.integer :api_id, :unique => true
      t.string :status
      t.string :name
      t.references :company
      t.timestamps
    end
  end
end
