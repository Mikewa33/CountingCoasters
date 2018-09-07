class CreateCoasterModels < ActiveRecord::Migration[5.1]
  def change
    create_table :coaster_models do |t|
      t.integer :api_id, :unique => true
      t.string :status
      t.string :name
      t.references :company
      t.references :model_line
      t.timestamps
    end
  end
end
