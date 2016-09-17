class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.date :date
      t.float :amount

      t.timestamps null: false
    end
  end
end
