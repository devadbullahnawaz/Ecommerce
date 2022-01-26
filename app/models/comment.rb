# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true

  validates :content, presence: true, length: { maximum: 250 }
end
