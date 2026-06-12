class Section < ApplicationRecord
  belongs_to :cv
  has_many :entries, -> { order(:display_order) }, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true

  accepts_nested_attributes_for :entries, allow_destroy: true
end
