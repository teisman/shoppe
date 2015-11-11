class CreateJoinTableProductCreator < ActiveRecord::Migration
  def change
    create_join_table :creators, :products do |t|
      t.index [:creator_id, :product_id]
      t.index [:product_id, :creator_id]
    end
  end
end
