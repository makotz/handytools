class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_owner, only: [:edit, :destroy, :update]

  def new
    @question = Question.new
  end

  def create
     @question      = Question.new question_params
     @question.user = current_user
     if @question.save
       if @question.tweet_it
         client = Twitter::REST::Client.new do |config|
           config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
           config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
           config.access_token        = current_user.twitter_token
           config.access_token_secret = current_user.twitter_secret
         end
         client.update "#Question: #{@question.title} #{question_url(@question)}"
       end
       redirect_to question_path(@question), notice: "Question created!"
     else
       flash[:alert] = "Question not created!"
       render :new
     end
   end

  def show
    @question = Question.find params[:id]
    # question_params = params.require(:question).permit(:view_count)
    @question.increment!(:view_count)
    @answer = Answer.new
    respond_to do |format|
      format.html
      format.json { render json: {question: @question, answers: @question.answers} }
    end
  end

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(7)
    respond_to do |format|
      format.html
      format.json {render json: @questions }
    end
  end

  def edit
  end

  def update
    @question.slug = nil
    if @question.update question_params
      redirect_to question_path(@question), notice: "Question updated"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question deleted"
  end

  def new_first_answers
    answers.order(created_at: :desc)
  end

  def current_user_vote
    @question.vote_for(current_user)
  end
  helper_method :current_user_vote

  private

  def question_params
    question_params = params.require(:question).permit(:title, :body, :category_id, :image, :tweet_it)
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize_owner
    unless can? :manage, @question
      redirect_to root_path, alert: "access denied"
    end
  end

end
