class ForumsController < ApplicationController
  def index
  	@forums = Forum.all
  	@topics = Topic.includes(:forum, :user)
  end

  def show
  	@forums = Forum.all
  	@forum = Forum.find(params[:id])
  end
end
