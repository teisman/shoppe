class CreateShoppeExhibitions < ActiveRecord::Migration
  def change
    create_table :shoppe_exhibitions do |t|
      t.string :name
      t.string :permalink
      t.text :description
      t.date :from_date
      t.date :to_date
    end
    add_index :shoppe_exhibitions, :permalink
  end
end
