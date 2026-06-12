class Entry < ApplicationRecord
  belongs_to :section, optional: true
  has_many :bullets, -> { order(:display_order) }, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true

  accepts_nested_attributes_for :bullets, allow_destroy: true

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map(&:strip).reject(&:blank?).map do |name|
      Tag.find_or_create_by!(name: name)
    end
  end
end
