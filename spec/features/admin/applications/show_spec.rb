require 'rails_helper'

RSpec.describe 'the admin application show page' do
  describe 'When I visit an admin application show page' do
    describe 'For every pet that the application is for' do
      describe 'I see a button to approve the application for that specific pet' do
        it 'can approve a pet application'

        
      end

      describe 'I am taken back to the admin application show page' do
        describe 'And next to the pet that I approved, I do not see a button to approve this pet' do
          describe 'Instead I see an indicator next to the pet that they have been approved' do
            it "updates the application status from 'pending' to 'approved'"
          end
        end
      end
    end
  end
end