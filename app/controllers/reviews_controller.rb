class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update]
  before_action :require_user, except: [:index]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @recipe = Recipe.find(params[:id])
    @reviews = @recipe.reviews
    @reviews = @reviews.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
  end
  
  def create
    @review = Review.new(review_params)
    @review.chef = current_user
    @recipe = Recipe.find(params[:id])
    @review.recipe = @recipe
    
    if @review.save
      flash[:success] = "Your review is saved!"
      redirect_to recipe_path(@review.recipe)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @review.update(review_params)
      flash[:success] = "Your review was updated!"
      redirect_to recipe_path(@review.recipe)
    else
      render :edit
    end
  end
  
  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "The review is wiped from existance"
    redirect_to recipe_path(@review.recipe)
  end
 
  private
    def review_params
      params.require(:review).permit(:body)
    end
    
    def set_review
      @review = Review.find(params[:id])
    end
    
    def require_same_user
      if current_user != @review.chef && !current_user.admin?
        flash[:danger] = "You can only edit your own review or be an all powerful Admin."
        redirect_to recipe_path(@review.recipe)
      end
    end
    
    def admin_user
      redirect_to recipe_path(@review.recipe) unless current_user.admin?
    end
    
end