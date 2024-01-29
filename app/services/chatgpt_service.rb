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
          { role: "system", content: "You are a professional presenter. response to japanese" }, 
          { role: "assistant", content: prompt },
          { role: "user", content: "この文章をPREP法を使って300文字以内で文章を作成してください" }
        ],
        temperature: 0.7, # 応答のランダム性を指定
        max_tokens: 800,  # 応答の長さを指定
      },
    )
    response['choices'].first['message']['content']
  end
end