FactoryBot.define do
  factory :example do
    sentence { "sentence_test" }

    trait :example_character_over do
      sentence { "プログラミング学習は、現代社会で必要不可欠なスキルの一つとなりつつあります。まず初めに、PythonやJavaScriptなどの基本的なプログラミング言語からスタートし、プログラムの基本構造や文法を理解することが大切です。その後、アルゴリズムやデータ構造などのコンセプトを学び、実践的な問題に応用できるようになりましょう。プロジェクトを通じた実践経験が、理論を深める一助となります。オンラインの学習プラットフォームやコミュニティを活用し、他の学習者と情報を共有しながらスキルを向上させていくことが重要です。継続的な学習と自己評価を通じて、着実にプログラミングスキルを高め、将来のキャリアやプロジェクトに活かしていくことが期待されます。" }

      association :memo
    end

    association :memo
  end
end
