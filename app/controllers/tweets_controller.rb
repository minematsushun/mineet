class TweetsController < ApplicationController
before_action :move_to_index , except: :index

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def show
  end

  def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    flash[:notice] = "新規投稿完了しました"
    redirect_to :root
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
    flash[:notice] = "投稿削除しました"
    redirect_to :root
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params) if tweet.user_id == current_user.id
    flash[:notice] = "投稿更新完了しました"
    redirect_to :root
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text)
  end



  def move_to_index
    redirect_to :root unless user_signed_in?
  end
end
