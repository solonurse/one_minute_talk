require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    # libディレクトリの以下のファイル以外を自動読み込みする
    config.autoload_lib(ignore: %w[assets tasks])

    # lib配下のディレクトリを読み込む
    config.paths.add 'lib', eager_load: true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # アプリケーションでの利用を許可するロケールのリストを渡す

    config.i18n.available_locales = %i[ja en]
    # ロケールを:en以外に変更する
    config.i18n.default_locale = :ja
    # アプリケーションでの利用を許可するロケールのリストを渡す（設定必須）
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]

    # Rails自体のアプリケーションの時刻
    config.time_zone = "Tokyo"
    # DBを読み書きする際に、DBに記録されている時間をどのタイムゾーンで読み込むかの設定
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.test_framework :rspec,
                       fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ
                       view_specs: false, # ビューファイル用のスペックを作成しない
                       helper_specs: false, # ヘルパーファイル用のスペックを作成しない
                       routing_specs: false # routes.rb用のスペックファイル作成しない
    end
  end
end
