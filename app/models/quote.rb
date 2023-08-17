class Quote < ApplicationRecord
    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    # users subscribed to the quotes stream will have receive an update to the quotes (index of quotes) to show the new quotes
    
    # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote",
    #                         locals: { quote: self }, target: "quotes" }

    # same as code above but more compact
    after_create_commit -> { broadcast_prepend_to "quotes" }
end
