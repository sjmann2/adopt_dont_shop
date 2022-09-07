class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :status, presence: true
  validates :description, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def status_approve_check
    # require "pry"; binding.pry
    if self.pet_applications.map { |petapp| petapp.application_status}.uniq == ['Approved']
      self.update(status: 'Approved')
      self.save
      # require "pry"; binding.pry
    end

  end
end
