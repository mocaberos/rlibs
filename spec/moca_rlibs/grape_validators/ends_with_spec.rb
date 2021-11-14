# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/spec/grape/extra_validators/end_with_spec.rb

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::EndsWith do
  module GrapeValidationsSpec
    module EndsWithValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, ends_with: 'JPY'
        end
        post '/not-array' do
          body false
        end

        params do
          optional :text, type: String, ends_with: %w[JPY USD]
        end
        post '/array' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::EndsWithValidatorSpec::API
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

  describe 'オプションに配列以外が指定された場合' do
    before :each do
      post '/not-array', params
    end

    context 'パラメータが指定された文字列で終わる場合' do
      let :text do
        '100JPY'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが指定された文字列で終わらない場合' do
      let :text do
        '100¥'
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

  describe 'オプションに配列が指定された場合' do
    before :each do |example|
      post '/array', params unless example.metadata[:skip_before_request_call]
    end

    context 'パラメータが配列内のどれかの文字列で終わる場合' do
      it '204のステータスコードを返すこと', skip_before_request_call: true do
        %w[100JPY 100USD].each do |text|
          post '/array', params: { text: text }
          expect(last_response.status).to eq(204)
        end
      end
    end

    context 'パラメータの末尾が配列内のどの文字列にもマッチしない場合' do
      let :text do
        '100¥'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end
  end
end
