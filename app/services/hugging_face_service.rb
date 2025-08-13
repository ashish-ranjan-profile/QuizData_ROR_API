require "net/http"
require "json"

class HuggingFaceService
  ENDPOINT = "https://api-inference.huggingface.co/models/koshkosh/quiz-generator"
  HEADERS = {
    "Authorization" => "Bearer #{ENV['HF_API_KEY']}",
    "Content-Type" => "application/json"
  }

  def self.fetch_quiz(topic)
    body = { inputs: topic.strip }.to_json
    uri = URI(ENDPOINT)

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.post(uri.path, body, HEADERS)
    end

    if response.code == "200"
      result = JSON.parse(response.body)
      result.is_a?(Array) ? result.first["generated_text"] : result["generated_text"]
    else
      raise "HuggingFace API Error: #{response.code} - #{response.message}"
    end
  rescue => e
    Rails.logger.error "❌ HuggingFace fetch_quiz error: #{e.message}"
    raise e
  end
end
