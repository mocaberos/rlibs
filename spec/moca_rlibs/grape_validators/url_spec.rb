# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::URL do
  module GrapeValidationsSpec
    module URLValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :url, type: String, url: true
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::URLValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    {
      url: url
    }
  end

  let :url do
    nil
  end

  before :each do
    post '/', params
  end

  context 'パラメータが正しいURLの場合' do
    context 'http://example.com' do
      let :url do
        'http://example.com'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'https://example.com' do
      let :url do
        'https://example.com'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータが正しいURLではない場合' do
    context 'hoge' do
      let :url do
        'hoge'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'sample.com' do
      let :url do
        'sample.com'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end
  end

  context 'パラメータがnilの場合' do
    it '204のステータスコードを返すこと' do
      expect(subject).to eq(204)
    end
  end
end
