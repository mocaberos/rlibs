# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/spec/grape/extra_validators/start_with_spec.rb

RSpec.describe MocaRlibs::GrapeValidators::StartsWith do
  module GrapeValidationsSpec
    module StartsWithValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, starts_with: 'https://'
        end
        post '/not-array' do
          body false
        end

        params do
          optional :text, type: String, starts_with: ['http://', 'https://']
        end
        post '/array' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::StartsWithValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    { text: text }
  end

  let :text do
    nil
  end

  describe 'オプションに配列以外を指定した場合' do
    before :each do
      post '/not-array', params
    end

    context 'パラメータが指定した文字列で始まる場合' do
      let :text do
        'https://example.com'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが指定した文字列で始まらない場合' do
      let :text do
        'http://example.com'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'パラメータがnilの場合' do
      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  describe 'オプションに配列を指定した場合' do
    before :each do |example|
      post '/array', params unless example.metadata[:skip_before_request_call]
    end

    context 'パラメータが指定した配列内のどれかの文字列から始まる場合' do
      it '204のステータスコードを返すこと', skip_before_request_call: true do
        %w[http://example.com https://example.com].each do |text|
          post '/array', { text: text }
          expect(last_response.status).to eq(204)
        end
      end
    end

    context 'パラメータの先頭が指定した配列内のどの文字列ともマッチしない場合' do
      let :text do
        'file://example.com'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end
  end
end
