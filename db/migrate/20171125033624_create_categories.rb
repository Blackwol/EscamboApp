class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :description, limit: 60

      t.timestamps null: false, limit: 6
    end
  end
end
