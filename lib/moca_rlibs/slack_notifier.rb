# frozen_string_literal: true

require 'slack-notifier'

module MocaRlibs
  # Slack通知クライアント
  class SlackNotifier
    begin
      PREFIX = Rails.application.class.module_parent_name&.upcase || 'MOCA'
    rescue NameError
      PREFIX = 'MOCA'
    end

    attr_reader :client

    SLACK_WEBHOOK_URL     = ENV["#{PREFIX}_SLACK_WEBHOOK_URL"]
    SLACK_DEFAULT_CHANNEL = ENV["#{PREFIX}_SLACK_DEFAULT_CHANNEL"]
    SLACK_DEFAULT_USER    = ENV["#{PREFIX}_SLACK_DEFAULT_USER"]

    # @param [String] webhook  Web Hook URL
    # @param [String] channel  チャンネル名
    # @param [String] username ユーザー名
    def initialize(webhook: nil, channel: nil, username: nil)
      @client = Slack::Notifier.new(
        webhook || SLACK_WEBHOOK_URL,
        channel:  channel  || SLACK_DEFAULT_CHANNEL,
        username: username || SLACK_DEFAULT_USER
      )
    end

    # シンプルなテキストを送信する
    #
    # @param [String] message 送信メッセージ
    # @param [String] at       メンション先
    def send(message, at: nil)
      @client.ping("#{at ? "<!#{at}> " : ''}#{message}")
    end

    # エラーログを送信
    #
    # @param [StandardError] err エラーオブジェクト
    def error(err)
      send("#{err.message}\n```#{err.backtrace}```", at: 'here')
    end

    # シンプルなテキストを送信する
    #
    # @param [String] message  送信メッセージ
    # @param [String] channel  チャンネル名
    # @param [String] username ユーザー名
    # @param [String] webhook  Web Hook URL
    # @param [String] at       メンション先
    def self.send(message, channel: nil, username: nil, webhook: nil, at: nil)
      new(webhook: webhook, channel: channel, username: username)
        .send(message, at: at)
    end

    # エラーログを送信
    #
    # @param [StandardError] err      エラーオブジェクト
    # @param [String]        channel  チャンネル名
    # @param [String]        username ユーザー名
    # @param [String]        webhook  Web Hook URL
    def self.error(err, channel: nil, username: nil, webhook: nil)
      backtrace = (err.backtrace&.join || 'no backtrace info').sub('`', '\'').slice(0, 2000)
      new(webhook: webhook, channel: channel, username: username)
        .send("#{err.message}\n```\n#{backtrace}\n```", at: 'here')
    end
  end
end
