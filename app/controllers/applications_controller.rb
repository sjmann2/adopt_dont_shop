class ApplicationsController < ApplicationController
  def show    
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
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
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
  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :status, :description)
  end
end
