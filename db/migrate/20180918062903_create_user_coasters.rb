class CreateUserCoasters < ActiveRecord::Migration[5.1]
  def change
    create_table :user_coasters do |t|
      t.uuid :user_id
      t.references :coaster
      t.boolean :has_rode
      t.integer :ride_count
      t.timestamps
    end
  end
end
