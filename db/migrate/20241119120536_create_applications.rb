class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.string :position
      t.string :company
      t.string :position_url
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
