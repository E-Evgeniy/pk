# frozen_string_literal: true

# Model for ProductKeys
class ProductKey < ApplicationRecord
  belongs_to :client
  validates :name, presence: true, uniqueness: true
end
