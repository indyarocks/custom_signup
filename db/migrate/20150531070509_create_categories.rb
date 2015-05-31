class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :user, index: true
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :categories, :name
    add_index :categories, [:user_id, :name], unique: true
  end
end
