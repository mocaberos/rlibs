# Ruby用ツールセット

## Dockerコンテナ内かどうかを判別する
```ruby
Docker.running_on_docker?
```

## Slack通知送信用クラス
SlackNotifier
```ruby
# シンプルなテキストを送信する
#
# @param [String] message 送信メッセージ
# @param [String] at       メンション先
send(message, at: nil)

# エラーログを送信
#
# @param [StandardError] err エラーオブジェクト
error(err)

# シンプルなテキストを送信する
#
# @param [String] message  送信メッセージ
# @param [String] channel  チャンネル名
# @param [String] username ユーザー名
# @param [String] webhook  Web Hook URL
# @param [String] at       メンション先
SlackNotifier.send(message, channel: nil, username: nil, webhook: nil, at: nil)

# エラーログを送信
#
# @param [StandardError] err      エラーオブジェクト
# @param [String]        channel  チャンネル名
# @param [String]        username ユーザー名
# @param [String]        webhook  Web Hook URL
SlackNotifier.error(err, channel: nil, username: nil, webhook: nil)
```
