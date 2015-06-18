class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    #@restaurant.reviews.create(review_params)
    @restaurant.reviews.create(review_params.merge({user:current_user}))
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    # why do we need to pass in restaurant when we don't use it?
    @review = Review.find(params[:id])
    if @review.can_you_delete?(current_user)
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = "can't delete another review"
      redirect_to '/restaurants'
    end
  end

end
