class Cv < ApplicationRecord
  belongs_to :user, optional: true
  has_many :sections, -> { order(:display_order) }, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true
  validates :email, presence: true
end
