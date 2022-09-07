require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it {should have_many(:pets).through(:pet_applications)}
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_numericality_of(:zipcode) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:description) }
  end

  describe 'instance methods' do
    before :each do
      @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
      @application_2 = Application.create!(name: "Chelsea Marks", street_address: "211 N Clay Ave", city: "Winnebago", state: "MN", zipcode: 55012, status: "In Progress", description: "Idk")
      @application_3 = Application.create!(name: "George Smith", street_address: "2354 E Brick Ln", city: "Salt Lake City", state: "UT", zipcode: 21097, status: "Approved", description: "I love animals")
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 13)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
      @application.pets << @pet_1
    end

    describe 'render_description?' do
      it 'renders the description form based on application pet count and application status' do
        expect(@application.render_description?).to eq(true)
        expect(@application_2.render_description?).to eq(false)
      end

      it 'renders the search form based on application status' do
        expect(@application_2.render_search?).to eq(true)
        expect(@application_3.render_search?).to eq(false)
      end
    end
  end
end
  

