class Api::V1::QuizHistoriesController < ApplicationController
      before_action :authenticate_user! # if using Devise+JWT

      def create
        history = current_user.quiz_histories.create(quiz_history_params)
        if history.persisted?
          render json: { message: "History saved", data: history }, status: :created
        else
          render json: { error: history.errors.full_messages }, status: :unprocessable_entity
        end
      end


  def index
      histories = current_user.quiz_histories.order(created_at: :desc)

      formatted_history = histories.map do |history|
    {
      id: history.id,
      quiz_topic: history.quiz_topic,
      level: history.level,
      score: history.score,
      total_questions: history.total_questions,
      correct_answers: history.correct_answers,
      attempted_questions: history.attempted_questions,
      date: history.created_at.iso8601
    }
  end

  render json: {
    user_id: current_user.id,
    history: formatted_history
  }
  end




 # DELETE /api/v1/quiz_histories/:id
 def destroy
  quiz_history = current_user.quiz_histories.find_by(id: params[:id])

  if quiz_history
    quiz_history.destroy
    render json: { message: "Quiz history deleted successfully" }, status: :ok
  else
    render json: { error: "Quiz history not found" }, status: :not_found
  end
 end

      private

      def quiz_history_params
        params.require(:quiz_history).permit(:quiz_topic, :level, :score, :total_questions, :correct_answers, :attempted_questions, :attempted_at)
      end
end
