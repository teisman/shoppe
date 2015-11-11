module Shoppe
  class ProductCreator < ActiveRecord::Base
    self.table_name = 'creators_products'

    belongs_to :product, class_name: 'Shoppe::Product'
    belongs_to :creator, class_name: 'Shoppe::Creator'

    validates_presence_of :product, :creator
  end
end
