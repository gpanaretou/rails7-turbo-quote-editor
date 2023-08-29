class Company < ApplicationRecord

    has_many :users, dependent: :destroy
    has_many :quotes, dependent: :destroy

    validates :name, presence: true

    def self.new_guest
        new { |u| u.guest = true }
    end


end
