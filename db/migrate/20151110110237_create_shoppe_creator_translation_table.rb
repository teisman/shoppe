class CreateShoppeCreatorTranslationTable < ActiveRecord::Migration
  def up
    Shoppe::Creator.create_translation_table! :name => :string, :permalink => :string, :description => :text, :short_description => :text
  end
  def down
    Shoppe::Creator.drop_translation_table!
  end
end
