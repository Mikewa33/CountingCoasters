class CreateCoasters < ActiveRecord::Migration[5.1]
  def change
    create_table :coasters do |t|

      t.timestamps
    end
  end
end
