class AddParkNameToCoasters < ActiveRecord::Migration[5.1]
  def change
    add_column :coasters, :park_name, :string
  end
end
