# Github Repository Search

![ezgif-4-16850e3b19](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/ace86cc2-b36b-4d0e-83c4-d3060a403e6a)


## ページ一覧

### トップページ

英語 | 日本語
--|--
![IMG_7866003D1996-1](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/9d093a82-e7bc-466e-bc7e-3de0a28a5445) | ![8AD9232D-DB64-4277-B549-CF7EF0CBCB9C](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/1bceab93-ab56-4615-a2af-7f42b7dd0e35)

### 検索ページ

通常(light)| 通常(dark) | 0件 | エラー
--|--|--|--
![D19D5865-5526-4416-BA4E-CE227D956637](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/ae16c715-38e0-4010-98dd-9758d02399cf) | ![E6C9EF03-8772-4C95-93D6-D07CFEB59CE7](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/f91f4e1d-75bb-495c-a679-b1d986a004b1) | ![7E737C7A-E4A9-4559-8787-8407823D4E88](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/5f68468d-f2ae-4a0f-a188-1b37aff41a93) | ![IMG_BA37282E35A5-1](https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/4b5f27bc-0e6c-4fb5-8425-816dd22a4cca)

### 詳細ページ

<img src="https://github.com/RYO1223/flutter-engineer-codecheck/assets/70420716/99e7261e-ce9a-4185-9f56-b0238d129269" width="25%" />

## 技術スタック

- Git ブランチモデル - [git-flow](https://nvie.com/posts/a-successful-git-branching-model/)
- アーキテクチャ - [flutter-architecture-blueprints](https://github.com/wasabeef/flutter-architecture-blueprints)
- リンター
  - デフォルトの[flutter_lints](https://pub.dev/packages/flutter_lints)をさらに厳しめにした[pedantic_mono](https://pub.dev/packages/pedantic_mono)を導入してます。
  - 追加で[custom_lint](https://pub.dev/packages/custom_lint)を導入して[riverpod_lint](https://pub.dev/packages/riverpod_lint)を追加してます。
- フォーマッター - デフォルトのものを使用
- モデル - [freezed](https://pub.dev/packages/freezed)
- 多言語対応 - [flutter_localizations](https://pub.dev/packages/flutter_localization)
- 環境変数
  - dart-define-from-file を導入  [こちらの記事](https://zenn.dev/altiveinc/articles/separating-environments-in-flutter#ios%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AB%E7%92%B0%E5%A2%83%E3%82%92%E5%8F%8D%E6%98%A0%E3%81%95%E3%81%9B%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB%E5%BF%85%E8%A6%81%E3%81%AA%E3%81%93%E3%81%A8)を参考
  - GithubAPIトークンのために[dotenv]()を導入
- テスト
  - [mocktail]()を使用したUI・Widgetテスト
  - [golden_test]()を使用したゴールデンテスト
- ルーティング - [go_router]() & [go_router_builder]()
- CI/CD - Github Actionsでテスト、ビルド、デプロイ対応
- iOS/Android/Web対応

### 対応できていないこと

- [一部のCI/CD](https://github.com/RYO1223/flutter-engineer-codecheck/issues/10)
- [様々な環境でのゴールデンテスト](https://github.com/RYO1223/flutter-engineer-codecheck/issues/9)
- [テストコードの共通化](https://github.com/RYO1223/flutter-engineer-codecheck/issues/2)
- [アニメーションやリッチな表示](https://github.com/RYO1223/flutter-engineer-codecheck/issues/11)
- [横画面対応](https://github.com/RYO1223/flutter-engineer-codecheck/issues/12)

## アーキテクチャ詳細

こちらには私の見解が含まれています。間違ったことを言っていれば指摘してください😄

基本的に`flutter-architecture-blueprints`をそのまま使用しています。

### フォルダ構成

```lib/
├── data/
│   ├── model/
│   │   └── [model_name].dart
│   ├── remote/
│   │   ├── base_dio.dart
│   │   ├── [remote_name]_dio.dart
│   │   └── [remote_name]_data_source.dart
│   └── repository/
│       ├── [repository_name]_repository.dart
│       └── [repository_name]_repository_impl.dart
├── ui/
│   ├── component/
│   ├── theme/
│   │   └── app_theme.dart
│   └── [page_name]/
│       └── [page_name]_page.dart
├── view_model/
│   └── [VM_name]/
│       ├── [VM_name]_view_model.dart
│       └── [VM_name]_view_model_state.dart
├── app.dart
└── main.dart
```

### View層のルール

- 各ページは`ConsumerWidget`か`ConsumerStatefulWidget`を継承します
- 各ページのbuild()の一番上に依存しているViewModelを書きます。基本的にページ以下のコンポーネントからViewModelに依存しないでください。（ページ毎にリビルドされるが、パフォーマンスに問題がある場合はコンポーネントから呼び出して良いものとする）
- ページからコンポーネントに引数を渡す場合はなるべく最小限にしてください。関数はページで定義してください。
- 他のページに遷移する場合も引数は最小限にしてください（例えば、インスタンスを直接渡すのではなくidのみ渡すようにして、遷移先でviewModelからインスタンスを取得する）
- 特定のページでしか使用しないコンポーネントはページフォルダに作っても良い

### ViewModelのルール

- RiverpodのNotiferで作成してください
- ステートが複雑な場合は同じフォルダに`[VM_name]_view_model_state.dart`を作成してください。ステートはfreezedで作成してください
- リポジトリを使用する場合はリポジトリのインターフェイスに依存してください
- 各関数はデータを直接返さないようにしてください。必ずstateを更新して、Notifierを通してViewをリビルドさせてください。

### Repositoryのルール

- 必ずインターフェイスと実装を分けてください。こうするとテスト時にモックを作成しやすくなります。
- Repositoryはアプリ内外を繋ぐ役目があります。関数名はアプリ内での表記にしてください。remoteやlocalのデータソースの呼び出しはアプリ外の表記にしてください。
  - 例えばアプリ内では`Repo`と呼んでいるが、アプリ外では`Repository`と呼んでいるのでRepositoryで変換する
  - アプリ内ではオブジェクトは`Model`として扱われるが、アプリ外では`json`でデータを持っているので変換する

### Remoteのルール

- それぞれのRemote毎にBaseDioを拡張した[Remote]Dioを作成してください。
- RESTAPIの場合はRetrofitを使用して自動生成してください
- 関数名などはアプリ外の表記をそのまま使用してください。アプリ内外の名前の変換はRepositoryで行います。
- Retrofitはモデル変換まで自動で行いますが、モデル変換はRepositoryの責務なので、[RetrofitObject](https://github.com/RYO1223/flutter-engineer-codecheck/blob/develop/lib/data/remote/retrofit_object.dart)を使用してjsonをそのまま保持するようにしてください。

### Localのルール

今回のアプリでは使用していないのでわかりません。


以下オリジナルのまま

---

# 株式会社ゆめみ Flutter エンジニアコードチェック課題

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に Flutter エンジニアを希望する方に出す課題用のプロジェクトです。 本課題が与えられた方は、以下を詳しく読んだ上で課題に取り組んでください。

## 概要

以下の要件を満たす、Android・iOS で動作するアプリを Flutter で作成してください。

## 要件

### 環境

- IDE・SDK・プログラミング言語については、基本的に最新の安定版を利用すること
- 最新の安定版以外を利用する場合は、理由も含めて README に記載すること
- 状態管理パッケージには Provider/Riverpod のいずれかを使うこと
- サードパーティーライブラリについては、オープンソースのものに限り制限しない

### 対象 OS バージョン

基本的に Flutter プロジェクト作成時のバージョンにすること

|         | OS Version |
| ------- | ---------- |
| iOS     | 9.0 ~ 15.2 |
| Android | 4.1 ~ 12   |

※ 本プロジェクト更新時点

### 動作

- 何かしらのキーワードを入力できる
- 入力したキーワードで GitHub のリポジトリを検索できる
- GitHub のリポジトリを検索する際、GitHub API（[`search/repositories`](https://docs.github.com/ja/rest/reference/search#search-repositories)）を利用する
  - [github | Dart Package](https://pub.dev/packages/github) のようなパッケージは利用せず、API を呼ぶ処理を自分で実装すること
- 検索結果は一覧で概要（リポジトリ名）を表示する
- 検索結果のアイテムをタップしたら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示する

### デザイン

マテリアルデザインに準拠すること

## 提出方法

- GitHub の public リポジトリの URL をお知らせください
- 別の方法で提出する場合はご相談ください（Git のコミット履歴が分かる形式が望ましいです）
- この課題とは別のコード(ご自身で公開されている OSS 等)をもって課題の提出とすることをご希望の場合はご相談ください

## 評価ポイント

- レビューのしやすさ
  - README の充実
  - 適切なコメント
  - GitHub のプルリクエスト機能などの利用
- Git
  - 適切な gitignore の設定
  - 適切なコミット粒度
  - 適切なブランチ運用
- 簡潔性・可読性・安全性・保守性の高いコード
- Dart の言語機能を適切に使いこなせているか
- テスト
  - テストが導入しやすい構成
  - Unit・UI テストがある
- UI/UX
  - エラー発生時の処理
  - 画面回転・様々な画面サイズ対応
  - Theme の適切な利用・ダークモードの対応
  - 多言語対応
  - アニメーションなど
- CI/CD
  - ビルド
  - テスト
  - リント
  - フォーマット
  - 仮のデプロイ環境

上記以外でも高く評価できるポイントがあれば同等に考慮します。

アピールする点があれば、README に箇条書きなどで記載してください。

## 参考記事

評価ポイントについて詳しくまとめた記事がありますので、ぜひご覧ください。

- [私が（iOS エンジニアの）採用でコードチェックする時何を見ているのか](https://qiita.com/lovee/items/d76c68341ec3e7beb611)
- [ゆめみの Android の採用コーディング試験を公開しました](https://qiita.com/blendthink/items/aa70b8b3106fb4e3555f)

## AI サービスの利用について

ChatGPT 等の AI サービスを利用することは、禁止しておりません。

利用にあたって工夫したプロンプトやソースコメント等をご提出頂くことで、加点評価する場合もあります。(減点評価はありません)

また、弊社コードチェック担当者も AI サービスを利用させていただく場合があります。
AI サービスの利用は差し控えてもらいたい等のご要望があれば、お気軽にお知らせください。

## Mac をお持ちでない場合について

Mac をお持ちでない場合は課題提出時にその旨お伝えください。
iOS に関連するコード、動作をレビュー対象から除外いたします。
