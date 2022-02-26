class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.references :task, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
