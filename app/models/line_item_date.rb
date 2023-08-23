class LineItemDate < ApplicationRecord
  belongs_to :quote

  validates :date, presence: ture, uniqueness: { scope :quote_id }

  scope :ordered, -> { order(date: :asc) }
end
