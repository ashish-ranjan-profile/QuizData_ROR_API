class Place < ApplicationRecord
  has_many :images, as: :imageable

  validates :name, :description, :state, :city, :country, presence: true
accepts_nested_attributes_for :images, reject_if: ->(attributes) { attributes["url"].blank? }
end
