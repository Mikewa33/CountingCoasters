class CreateUserParks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_parks do |t|
      t.uuid :user_id
      t.references :park
      t.boolean :has_visited
      t.integer :visit_count
      t.timestamps
    end
  end
end
