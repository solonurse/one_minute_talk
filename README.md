# one_minute_talk
■サービス概要  
短い時間で簡潔に話すことが苦手な人が話したいことを整理できるマインドアップアプリです。  
自分が伝えたいことを簡潔にまとめることで自分の考えを客観的に整理することができます。  
また、整理した内容を1分で伝わるコンパクトな文章に変換できます。

■ このサービスへの思い・作りたい理由  
よく、一生懸命話したいことを話しても相手から「結局、何が言いたいの？」「話が長いね」など言われた経験がある方がいらっしゃると思います。  
自分も看護師として働いていた頃、朝のカンファレンスや引き継ぎをする際に「何が言いたいのか分からない」とよく言われていました。なぜなら自分の伝えたいことが整理できないまま話してしまい、相手に伝えたいことが全く伝わらなかったからです。  
しかし、大きなミーティングならまだしも毎朝のショートミーティングのために毎回話すことを整理し、まとめるのは慣れていないと大変です。  
そこで、簡単に自分の思考を整理し、話す内容をまとめてくれるアプリがあれば相手との認識の齟齬や説明のためにお互いの時間を無駄に浪費せずに済むのではないか思い、このサービスを考えました。

■ ユーザー層について  
自分の意見を人に伝えることが苦手で、よく相手から「何が言いたいの？」と言われてしまう方。

■サービスの利用イメージ  
ユーザーは4つの項目を入力することで自身の考えを整理し、それをメモとして登録することでミーティング前などいつでも内容を振り返ることができます。  
また、伝えたいポイントを結論⇒根拠⇒具体例の順番に簡潔に説明することで正しく自分の考えを伝えることができ、相手との認識の齟齬やお互いの時間を浪費せずに済みます。

■ ユーザーの獲得について  
Xにて告知。

■ サービスの差別化ポイント・推しポイント  
類似サービス: MindNodeなどのマインドアップアプリ  
ロジックツリーによる問題に対する原因や解決策を導き出すためのアプリは多くあります。しかし、ピラミッドストラクチャーのような自身の主張とその根拠を説明するためのアプリは調査したところ見つかりませんでした。  
また、発表に5~10分かかるようなプレゼンテーションではなく、朝のショートミーティングや人に頼み事をする時など短時間で簡潔に説明するためのアプリは見つかりませんでした。

■ 機能候補  
MVPリリース時に作っていたいもの
- ユーザー登録機能
- ログイン機能
- メモ機能
	- ユーザーは伝えたい内容を「プロジェクトの報告をする」など大まかにタイトル付けする。
	- タイトルを説明するための要素を箇条書きで書き出す。
	- 書き出した要素の中から伝えたいことを1~3位まで選ぶ。
	- 要素を選んだ理由を箇条書きで書く。
- 入力した内容からピラミッドストラクチャーを作成する。
- 入力した内容をもとに例文を自動作成する。
	- 自動作成された文章は手動で修正できる。

本リリースまでに作っていたいもの
- リマインダー機能
- フォルダ機能
- ログイン機能
	- Googleアカウントでログイン
	- Twitterアカウントでログイン

可能であれば作りたいもの
- 発表練習用の1分タイマー機能
- 話す速度の評価機能

■ 機能の実装方針予定  
- 入力した内容をもとに例文を自動作成
	- ユーザーが入力した内容をもとに文章作成API(Chat-GPT)によって、結論(タイトル)⇒根拠(要素)⇒具体例(要素を選んだ理由)の順番に1分で話せる300文字以内の例文を自動作成する。
- 話す速度の評価機能
	- Web Speech APIによって音声を文章に変換。文章の文字数から話す速度が速いか遅いかを判定する。
- ピラミッドストラクチャーの作成
	- CSSを使用してピラミッド型の組織図を作成し、その中にユーザーが入力した結論、根拠、具体例を組織図の中に当てはめる。