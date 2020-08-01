class ReviewsController < ApplicationController
    before_action :set_review, only: [:update, :show, :edit, :destroy]

    def index
    end

    def new
    end

    def create
        @review = Review.create(review_params)
        @review.user_id = current_user.id
        @review.save
        redirect_to recipe_path(@review.recipe), alert: @review.errors.full_messages.join(', ')
    end

    def show
    end

    def edit
        verify
    end

    def update
        verify
        if @review.update(review_params)
            redirect_to recipe_path(@review.recipe), notice: "Review successfully updated."
        else
            render :edit
        end
    end

    def destroy
        verify
        recipe = @review.recipe
        @review.destroy
        redirect_to recipe_path(recipe), alert: "Review successfully deleted."
    end

    private

    def set_review
        @review = Review.find_by_id(params[:id])
    end

    def review_params
        params.require(:review).permit(:rating, :content, :user_id, :recipe_id)
    end

    def verify
        if @review.user != current_user
            redirect to recipe_path(@review.recipe), alert: "You do not have permission to do that."
        end
    end

end
