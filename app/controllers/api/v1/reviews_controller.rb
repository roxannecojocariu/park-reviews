class Api::V1::ReviewsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    reviews = Park.find(params[:park_id]).reviews

    reviews_users = reviews.map do |review|
      review.user.email
    end

    formatted_reviews = []
    reviews.each_with_index do |val, index|
      upvote_values = val.review_upvotes.map { |upvote| upvote.value }
      upvote_total = 0
      downvote_total = 0
      upvote_values.each do |val|
        upvote_total += 1 if val === 1
        downvote_total +=1 if val === -1
      end
      formatted_reviews.push(
        {
          review_data: val,
          user_data: reviews_users[index],
          upvote_total: upvote_total,
          downvote_total: downvote_total
        }
      )
    end

    render json: { formatted_reviews: formatted_reviews, formatted_user: current_user }
  end

  def show
    render json: { review: Review.find(params[:id]), formatted_user: current_user }
  end

  def create
    review = Review.new(review_params)
    review.user = current_user
    if review.save
      render json: { review: review, errors: [] }
    else
      render json: { review: {}, errors: review.errors.full_messages }
    end
  end

  def edit
    render json: { review: Review.find(params[:id]), errors: ''  }
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      render json: {review: review}

    else
      render json: {errors: review.errors}, status: 422
    end
  end

  def destroy
    review = Review.find(params[:id])

    if review.destroy
      reviews = review.park.reviews
      render json: { reviews: reviews, errors: [] }
    else
      reviews = review.park.reviews
      render json: { reviews: reviews, errors: review.errors}
    end

  end

  private

  def review_params
    params.require(:review).permit(:park_id, :rating, :body)
  end

  def authorize_admin
    if !current_user.admin?
      flash[:notice] = "You Do not have access to this page"
      redirect_to parks_path
    end
  end
end
