# Ruby用ツールセット

## インストール
```ruby
gem 'moca_rlibs'
```

## Dockerコンテナ内かどうかを判別する
```ruby
MocaRlibs::Docker.running_on_docker?
```

## CodeBuild上で"直接"実行されているかを判別する。
```ruby
MocaRlibs::CodeBuild.running_on_codebuild?
```

## Slack通知送信用クラス
```ruby
# インスタンス化
client = MocaRlibs::SlackNotifier.new

# シンプルなテキストを送信する
#
# @param [String] message 送信メッセージ
# @param [String] at       メンション先
client.send('some message')

# エラーログを送信
#
# @param [StandardError] err エラーオブジェクト
client.error(StandardError.new('some error occurred'))

# シンプルなテキストを送信する
#
# @param [String] message  送信メッセージ
# @param [String] channel  チャンネル名
# @param [String] username ユーザー名
# @param [String] webhook  Web Hook URL
# @param [String] at       メンション先
MocaRlibs::SlackNotifier.send('some message')

# エラーログを送信
#
# @param [StandardError] err      エラーオブジェクト
# @param [String]        channel  チャンネル名
# @param [String]        username ユーザー名
# @param [String]        webhook  Web Hook URL
MocaRlibs::SlackNotifier.error(StandardError.new('some error occurred'))
```
