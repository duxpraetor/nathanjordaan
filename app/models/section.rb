class Section < ApplicationRecord
  belongs_to :cv
  has_many :entries, -> { order(:display_order) }, dependent: :destroy

  validates :title, presence: true
end
