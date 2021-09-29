# frozen_string_literal: true

require 'moca_rlibs'
require 'slack-notifier'

RSpec.describe MocaRlibs::SlackNotifier do
  describe '.send' do
    subject do
      described_class.new.send('メッセージ')
    end

    let :client do
      double(Slack::Notifier)
    end

    before :each do
      allow(Slack::Notifier).to receive(:new).and_return(client)
      allow(client).to receive(:ping).and_return(nil)
    end

    it 'メッセージを送信できること' do
      expect(client).to receive(:ping).with(anything)

      subject
    end
  end

  describe '.error' do
    subject do
      described_class.new.error(StandardError.new('some error message'))
    end

    let :client do
      double(Slack::Notifier)
    end

    before :each do
      allow(Slack::Notifier).to receive(:new).and_return(client)
      allow(client).to receive(:ping).and_return(nil)
    end

    it 'メッセージを送信できること' do
      expect(client).to receive(:ping).with(anything)

      subject
    end
  end

  describe '#send' do
    subject do
      described_class.send('メッセージ', **params)
    end

    let :params do
      {
        channel:  'channel',
        username: 'username',
        webhook:  'webhook'
      }
    end

    let :client do
      double(Slack::Notifier)
    end

    before :each do
      allow(Slack::Notifier).to receive(:new).and_return(client)
      allow(client).to receive(:ping).and_return(nil)
    end

    it 'メッセージを送信できること' do
      expect(client).to receive(:ping)

      subject
    end
  end

  describe '#error' do
    subject do
      described_class.error(StandardError.new('some error message'), **params)
    end

    let :params do
      {
        channel:  'channel',
        username: 'username',
        webhook:  'webhook'
      }
    end

    let :client do
      double(Slack::Notifier)
    end

    before :each do
      allow(Slack::Notifier).to receive(:new).and_return(client)
      allow(client).to receive(:ping).and_return(nil)
    end

    it 'メッセージを送信できること' do
      expect(client).to receive(:ping)

      subject
    end
  end
end
