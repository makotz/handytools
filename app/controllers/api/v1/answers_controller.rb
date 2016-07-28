class Api::V1::AnswersController < Api::BaseController
  before_action :authenticate_api_user
  protect_from_forgery with: :null_session

  def create
    question = Question.find params[:question_id]
    answer = Answer.new answer_params
    answer.question = question
    answer.user = @user
    answer.save
    render json: {success: true}
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def authenticate_api_user
    @user = User.find_by_api_key params[:api_key]
    head :forbidden unless @user
  end

end
