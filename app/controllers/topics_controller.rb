class TopicsController < ApplicationController
  layout 'chat'

  before_action :authorize
  authorize_resource

  def index
    @topics = current_user.topics.order('created_at DESC')
    @topics = @topics.tagged_with(params[:tag]) if params[:tag]
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = current_user.topics.build
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      redirect_to topics_url
    else
      render 'new'
    end
  end

  private

    def topic_params
      params.require(:topic).permit(:text)
    end

end