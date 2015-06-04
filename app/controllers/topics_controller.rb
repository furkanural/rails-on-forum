class TopicsController < ApplicationController
  before_action :validate_user!, except: [:show]
  before_action only: [:edit, :update, :destroy] do
    validate_permission!(set_topic.user)
  end
  before_action :set_topic, only: [:edit, :update, :destroy]
  before_action only: [:new, :create] {@forum = Forum.find(params[:forum_id])}

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.includes(:forum, :comments, :user).find(params[:id])
    @comments = @topic.comments.includes(:user)
  end

  # GET /topics/new
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new(topic_params)
    @topic.user = current_user

    if @topic.save
      redirect_to topic_url(@topic), notice: 'Konu başarıyla oluşturuldu'
    else
      render :new
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        redirect_to topic_url(@topic), notice: 'Konu başarıyla güncellendi.'
      else
        render :edit
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    redirect_to root_url, notice: 'Konu başarıyla silindi.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :body)
    end
end
