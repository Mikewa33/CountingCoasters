class CreateCoasterModelTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :coaster_model_types do |t|
      t.references :coaster 
      t.references :coaster_model
      t.timestamps
    end
  end
end
