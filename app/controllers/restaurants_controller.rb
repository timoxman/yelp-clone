class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

#intention to create a record
  def new
    @restaurant = Restaurant.new
  end

#creates a record and then redirects to another place
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

# define which params we are going to allow us to pass to controller, without this security flaw.
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

# intention to alter record
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

# record is actually updated
  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end

end
