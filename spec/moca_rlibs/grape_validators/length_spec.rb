# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/spec/grape/extra_validators/length_spec.rb

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::Length do
  module GrapeValidationsSpec
    module LengthValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, length: 6
        end
        post '/integer' do
          body false
        end

        params do
          optional :text, type: String, length: 4..8
        end
        post '/range' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::LengthValidatorSpec::API
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

  describe 'パラメータに数値を指定した場合' do
    before :each do
      post '/integer', params
    end

    context 'パラメータが指定値よりも短い場合' do
      let :text do
        '12345'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'パラメータが指定値と同じ長さの場合' do
      let :text do
        '123456'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが指定値よりも長いの場合' do
      let :text do
        '1234567'
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

  describe 'パラメータに範囲を指定した場合' do
    before :each do |example|
      post '/range', params unless example.metadata[:skip_before_request_call]
    end

    context 'パラメータが指定の範囲よりも短い場合' do
      let :text do
        '123'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'パラメータが指定の範囲に含まれている場合', skip_before_request_call: true do
      it '204のステータスコードを返すこと' do
        post '/range', params: { text: '1234' }
        expect(last_response.status).to eq(204)

        post '/range', params: { text: '12345' }
        expect(last_response.status).to eq(204)

        post '/range', params: { text: '123456' }
        expect(last_response.status).to eq(204)

        post '/range', params: { text: '1234567' }
        expect(last_response.status).to eq(204)

        post '/range', params: { text: '12345678' }
        expect(last_response.status).to eq(204)
      end
    end

    context 'パラメータが指定の範囲よりも長い場合' do
      let :text do
        '123456789'
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
end
