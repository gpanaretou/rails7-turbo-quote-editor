class Quote < ApplicationRecord
    has_many :line_item_dates, dependent: :destroy
    has_many :line_items, through: :line_item_dates
    belongs_to :company

    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    # users subscribed to the quotes stream will have receive an update to the quotes (index of quotes) to show the new quotes
    
    # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote",
    #                         locals: { quote: self }, target: "quotes" }

    # same as code above but more compact
    # after_create_commit -> { broadcast_prepend_later_to "quotes" }
    # after_update_commit -> { broadcast_replace_later_to "quotes" }
    # after_destroy_commit -> { broadcast_remove_to "quotes" }
    broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

    def total_price 
        line_items.sum(&:total_price)
    end
end
