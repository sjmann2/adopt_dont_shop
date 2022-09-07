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

  def render_description?
    self.pets.count >=1 && self.status == 'In Progress'
  end

  def render_search?
    self.status == 'In Progress'
  end

  def status_approve_check

    if self.pet_applications.where(application_status: 'Approved').count == self.pet_applications.count
      self.update(status: 'Approved')
      self.save
    elsif self.pet_applications.where(application_status: 'Rejected').count >= 1
      self.update(status: 'Rejected')
      self.save
    end

  end
end
