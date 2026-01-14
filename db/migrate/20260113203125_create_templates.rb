class CreateTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :templates do |t|
      t.string :name
      t.text :description
      t.json :file_structure
      t.references :user, null: true, foreign_key: true
      t.boolean :is_public

      t.timestamps
    end
  end
end
