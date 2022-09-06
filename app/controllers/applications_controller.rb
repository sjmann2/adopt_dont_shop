class ApplicationsController < ApplicationController
  def show
    # @search_pets(pet_name) = Application.search_pets(pet_name)
    if params[:search]
      @pets = Pet.search(params[:search])
      @application = Application.find(params[:id])
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    if params[:name].blank? || params[:street_address].blank? || params[:city].blank? || params[:state].blank? || params[:zipcode].blank? || params[:status].blank?
      redirect_to "/applications/new"
      flash[:alert] = "Please fill in all fields"
    else
      application = Application.create!(applications_params)

      redirect_to "/applications/#{application.id}"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(description: params[:description])
    @application.update(status: 'Pending')
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :status, :description)
  end
end
