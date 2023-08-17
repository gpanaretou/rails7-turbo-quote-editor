class Quote < ApplicationRecord
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
    broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
end
