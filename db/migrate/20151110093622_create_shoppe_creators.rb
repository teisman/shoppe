class CreateShoppeCreators < ActiveRecord::Migration
  def change
    create_table :shoppe_creators do |t|
      t.string :name
      t.string :email
      t.string :website
      t.text :description
      t.text :short_description
      t.string :permalink
    end
    add_index :shoppe_creators, :permalink
  end
end
