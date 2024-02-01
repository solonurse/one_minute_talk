class ChatgptService
  require 'openai'

  def initialize
    api_key = Rails.application.credentials.chatgpt_api_key
    @openai = OpenAI::Client.new(access_token: api_key)
  end

  def chat(prompt)
    begin
      response = @openai.chat(
        parameters: {
          model: "gpt-3.5-turbo", # Required. # 使用するGPT-3のエンジンを指定
          messages: [
            { role: "system", content: "You are a professional presenter" }, 
            # { role: "assistant", content: prompt },
            { role: "user",
              content:
                "Please create a sentence using the following conditions.
                # conditions
                #{prompt}
                Please use the PREP method.
                Plese answer in Japanese.
                Output should be less than 350 tokens"
            }
          ],
          temperature: 0.7, # 応答のランダム性を指定
          max_tokens: 800,  # 応答の長さを指定
        },
      )
      response['choices'].first['message']['content']
    # rescue OpenAI::APIError => e
    #   # Chat-GPT APIからのエラーレスポンスを処理
    #   Rails.logger.error("Chat-GPT APIエラー: #{e.message}")
    #   raise APIError, "Chat-GPT APIからの回答を取得できませんでした。"
    rescue StandardError => e
      # その他の例外やエラーを処理
      # Rails.logger.error("Chat-GPT APIで予期せぬエラーが発生しました: #{e.message}")
      raise StandardError
      # , "Chat-GPT APIエラーが発生しました。"
    end
  end
end