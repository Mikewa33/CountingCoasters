class AddMoreLocationToPark < ActiveRecord::Migration[5.1]
  def change
    add_column :parks, :country, :string
    add_column :parks, :state, :string
    add_column :parks, :county, :string
    add_column :parks, :district, :string
    add_column :parks, :city, :string
  end
end
