class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable, :registerable

  belongs_to :company

  def name 
    email.split("@").first.capitalize
  end

  def self.new_guest 
    new { |u| u.guest = true }
  end
end
