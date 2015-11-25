require "globalize"

module Shoppe
  class Exhibition < ActiveRecord::Base

    self.table_name = 'shoppe_exhibitions'

    # Attachments for this creator
    has_many :attachments, :as => :parent, :dependent => :destroy, :autosave => true, :class_name => "Shoppe::Attachment"


    # Localisations
    translates :name, :permalink, :description

    validates :name, presence: true
    validates :description, presence: true
    validates :permalink, presence: true, uniqueness: true, permalink: true

    before_validation { self.permalink = self.name.parameterize if self.permalink.blank? && self.name.is_a?(String) }

    scope :ordered, -> { includes(:translations).order(:name) }

    def attachments=(attrs)
      if attrs["avatar"]["file"].present? then self.attachments.build(attrs["avatar"]) end
      if attrs["extra"]["file"].present? then attrs["extra"]["file"].each { |attr| self.attachments.build(file: attr, parent_id: attrs["extra"]["parent_id"], parent_type: attrs["extra"]["parent_type"]) } end
    end

    def avatar
      self.attachments.for("avatar")
    end

    def avatar_file=(file)
      self.attachments.build(file: file, role: 'avatar')
    end

  end
end

