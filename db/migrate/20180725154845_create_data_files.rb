class CreateDataFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :data_files do |t|

      t.timestamps
    end
  end
end
