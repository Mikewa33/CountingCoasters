class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.integer :api_id, :unique => true
      t.string :status
      t.string :location
      t.string :name
      t.timestamps
    end
  end
end
