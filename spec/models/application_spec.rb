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
      @pet_2 = Pet.create(adoptable: true, age: 7, breed: 'tabby', name: 'Garfield', shelter_id: @shelter.id)
      @application.pets << @pet_1
      @petapplication = PetApplication.create(pet_id: @pet_2.id, application_id: @application_2, application_status: 'Approved')
      @petapplication1 = PetApplication.create(pet_id: @pet_1.id, application_id: @application_1, application_status: 'Rejected')
      @petapplication2 = PetApplication.create(pet_id: @pet_2.id, application_id: @application_1, application_status: 'Approved')

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

    describe 'status_approve_check' do
      it 'can change appliation status to Approved' do
        @application_2.pet_applications << @petapplication
        @application_2.status_approve_check

        expect(@application_2.status).to eq('Approved')
      end

      it 'can change appliation status to Rejected' do
        @application_2.pet_applications << @petapplication1
        @application_2.pet_applications << @petapplication2

        @application_2.status_approve_check

        expect(@application_2.status).to eq('Rejected')
      end
    end
  end
end
