class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :cvs, through: :taggings, source: :taggable, source_type: "Cv"
  has_many :entries, through: :taggings, source: :taggable, source_type: "Entry"
  has_many :bullets, through: :taggings, source: :taggable, source_type: "Bullet"

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
