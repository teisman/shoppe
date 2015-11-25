class CreateShoppeExhibitionTranslationTable < ActiveRecord::Migration
  def up
    Shoppe::Exhibition.create_translation_table! :name => :string, :permalink => :string, :description => :text
  end
  def down
    Shoppe::Exhibition.drop_translation_table!
  end
end
