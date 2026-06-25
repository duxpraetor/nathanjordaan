class Entry < ApplicationRecord
  belongs_to :section, optional: true
  has_many :bullets, -> { order(:display_order) }, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
end
