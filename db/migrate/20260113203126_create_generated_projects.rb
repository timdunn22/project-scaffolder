class CreateGeneratedProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :generated_projects do |t|
      t.references :template, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.json :config_choices
      t.integer :download_count

      t.timestamps
    end
  end
end
