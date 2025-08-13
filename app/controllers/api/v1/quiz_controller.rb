class Api::V1::QuizController < ApplicationController
    before_action :authenticate_user!

  def generate
    topic = params[:topic]

    begin
      quiz_text = HuggingFaceService.fetch_quiz(topic)
      render json: { quiz: quiz_text }, status: :ok
    rescue => e
      render json: { error: "API request failed", message: e.message }, status: :bad_request
    end
  end
end
