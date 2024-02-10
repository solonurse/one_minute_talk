class ChatgptService
  require 'openai'

  def initialize
    api_key = Rails.application.credentials.chatgpt_api_key
    @openai = OpenAI::Client.new(access_token: api_key)
  end

  def chat(prompt)
    response = @openai.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required. # 使用するGPT-3のエンジンを指定
        messages: [
          { role: "system", content: "You are a professional presenter" },
          {
            role: "user",
            content:
              "Please create a sentence using the following conditions.
              # conditions
              #{prompt}
              Please use the PREP method.
              Plese answer in Japanese.
              Output should be less than 350 tokens"
          }
        ],
        temperature: 0.7 # 応答のランダム性を指定
      }
    )
    response['choices'].first['message']['content']
  # Chat-GPT APIからのエラーレスポンスを処理
  rescue Faraday::BadRequestError
    raise APIError
  # その他の例外やエラーを処理
  rescue StandardError
    raise StandardError
  end
end
