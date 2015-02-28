class FeedsController < ApplicationController
  before_action :require_logged_in!

  LIMIT = 20

  def show

    max_date = params[:max_created_at]

    @feed_tweets =
      current_user.feed_tweets(params[:limit] || LIMIT, max_date)
        .includes(:user)
    respond_to do |format|
      format.html { render :show }
      format.json { render :show }
    end
  end
end
