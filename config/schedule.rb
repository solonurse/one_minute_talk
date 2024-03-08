# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")

# Railsアプリケーションの実行環境（development、production、testなど）をシンボルで取得し、変数 rails_env に代入
rails_env = Rails.env.to_sym
# cronを実行する環境変数をセット
set :environment, rails_env

# コンテナ起動時の環境変数をcron独自の環境変数にパス
ENV.each { |k, v| env(k, v) }

# ログをアウトプットする
set :output, 'log/cron.log'

# 毎日AM9:00に実行
every 1.day, at: '09:00 am' do
  begin
    # Batch::RemindEventクラスのremind_eventの処理を実行する
    runner "Batch::RemindEvent.remind_event"
  rescue StandardError => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end
