class CreateCoasterCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :coaster_companies do |t|
      t.references :coaster 
      t.references :company
      t.timestamps
    end
  end
end
