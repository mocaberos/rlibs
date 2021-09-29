# Ruby用ツールセット

[![Build Status](https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiekhCRy9vSkZhL3BSR1hCV0NvSkc3b3NMcm5MQnlnakkwVFZhWFI1bzZpTzZONmxMeFVLcjNKODhlQWo5ZGtFYmpLcjNQZVFqdzNVZTRBbFFJZ3h1NTNvPSIsIml2UGFyYW1ldGVyU3BlYyI6ImU4dXdib0NpOE1IbHJiYVQiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)](https://ap-northeast-1.console.aws.amazon.com/codesuite/codebuild/085041388644/projects/rlibs)
[![codecov](https://codecov.io/gh/mocaberos/rlibs/branch/master/graph/badge.svg?token=L6SB5CH8KN)](https://codecov.io/gh/mocaberos/rlibs)

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
