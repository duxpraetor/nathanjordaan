class Bullet < ApplicationRecord
  belongs_to :entry
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :description, presence: true
end
