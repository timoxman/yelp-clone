class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new

  end

  def create
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

# define which params we are going to allow us to pass to controller
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

end
