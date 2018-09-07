class CreateParks < ActiveRecord::Migration[5.1]
  def change
    create_table :parks do |t|
      t.integer :api_id, :unique => true
      t.string :status
      t.string :location
      t.string :name
      t.string :open_date
      t.string :website_url
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :long, {:precision=>10, :scale=>6}
      t.timestamps
    end
  end
end
