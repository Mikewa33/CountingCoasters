class AddCoasterStats < ActiveRecord::Migration[5.1]
  def change
    add_column :coasters, :coaster_length, :string
    add_column :coasters, :coaster_height, :string
    add_column :coasters, :coaster_drop, :string
    add_column :coasters, :coaster_speed, :string
    add_column :coasters, :coaster_inversions, :string
    add_column :coasters, :coaster_duration, :string

  end
end
