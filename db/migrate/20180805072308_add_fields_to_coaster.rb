class AddFieldsToCoaster < ActiveRecord::Migration[5.1]
  def change
    add_reference :coasters, :park
    add_column :coasters, :name, :string
    add_column :coasters, :status, :string
    add_column :coasters, :coaster_type, :string
    add_column :coasters, :coaster_design, :string
    add_column :coasters, :opened, :string
    add_column :coasters, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :coasters, :long, :decimal, {:precision=>10, :scale=>6}
    add_column :coasters, :api_id, :integer, :unique => true
  end
end
