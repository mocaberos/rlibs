# Ruby用ツールセット

[![Build Status](https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiekhCRy9vSkZhL3BSR1hCV0NvSkc3b3NMcm5MQnlnakkwVFZhWFI1bzZpTzZONmxMeFVLcjNKODhlQWo5ZGtFYmpLcjNQZVFqdzNVZTRBbFFJZ3h1NTNvPSIsIml2UGFyYW1ldGVyU3BlYyI6ImU4dXdib0NpOE1IbHJiYVQiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)](https://ap-northeast-1.console.aws.amazon.com/codesuite/codebuild/085041388644/projects/rlibs)
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

## ActiveModelカスタムバリデーション
半角アルファベットのみを許可する
```ruby
class UserModel
  include ActiveModel::Validations

  validates :user_name, only_alpha: true
end
```
半角アルファベットと数字のみを許可する
```ruby
class UserModel
  include ActiveModel::Validations

  validates :user_name, only_alpha_numeric: true
end
```
数字のみの文字列を許可する
```ruby
class UserModel
  include ActiveModel::Validations

  validates :user_name, only_numbers: true
end
```
アスキー文字のみの文字列を許可する
```ruby
class UserModel
  include ActiveModel::Validations

  validates :user_name, only_ascii: true
end
```
出力可能なアスキー文字のみかどうかをチェックする(半角英数字、一部の記号)
```ruby
class UserModel
  include ActiveModel::Validations

  validates :user_name, only_printable: true
end
```
メールアドレスのフォーマットチェック
https://github.com/K-and-R/email_validator
```ruby
class UserModel
  include ActiveModel::Validations

  validates :user_email, email: true
  validates :user_email, email: {mode: :strict, require_fqdn: true}
  validates :user_email, email: {domain: 'example.com'}
end
```

## Grapeカスタムバリデーション
メールアドレスのフォーマットチェック(簡易チェック)
```ruby
params do
  requires :email, type: String, email: true
end
```
メールアドレスのフォーマットチェック(厳密チェック)(推奨)
```ruby
params do
  requires :email, type: String, email_strict: true
end
```
メールアドレスのフォーマットチェック(RFC-2822, RFC-5321)
```ruby
params do
  requires :email, type: String, email_rfc: true
end
```
URLのフォーマットチェック
```ruby
params do
  requires :url, type: String, url: true
end
```
文字列の長さ制限
```ruby
params do
  requires :name, type: String, length: 4
  requires :bio,  type: String, length: 4..512
end
```
プレフィックス制限
```ruby
params do
  requires :website, type: String, start_with: "https://"
  requires :website, type: String, start_with: %w(http:// https://)
end
```
サフィックス制限
```ruby
params do
  requires :price, type: String, end_with: "JPY"
  requires :price, type: String, end_with: %w(JPY USD)
end
```
数値の最大値制限
```ruby
params do
  requires :level, type: Integer, max: 5
end
```
数値の最大値制限(Proc)
```ruby
params do
  requires :level, type: Integer, max: ->(params) { params[:foo] + 1 }
end
```
数値の最小値制限
```ruby
params do
  requires :age, type: Integer, min: 0
end
```
数値の最小値制限(Proc)
```ruby
params do
  requires :level, type: Integer, min: ->(params) { params[:bar] - 1 }
end
```
アスキー文字しか含まないこと
```ruby
params do
  requires :text, type: String, only_ascii: true
end
```
文字列にアルファベットしか含まないこと
```ruby
params do
  requires :text, type: String, only_alpha: true
end
```
文字列に数字しか含まれないこと
```ruby
params do
  requires :text, type: String, only_numbers: true
end
```
文字列に英数字しか含まれないこと
```ruby
params do
  requires :text, type: String, only_alpha_numeric: true
end
```
出力可能なアスキー文字しか含まれないこと(半角英数字、一部の表示可能な記号)
```ruby
params do
  requires :text, type: String, only_printable: true
end
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
