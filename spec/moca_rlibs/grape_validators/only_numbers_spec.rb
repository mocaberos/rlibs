# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::OnlyNumbers do
  module GrapeValidationsSpec
    module OnlyNumbersValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, only_numbers: true
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::OnlyNumbersValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    {
      text: text
    }
  end

  let :text do
    nil
  end

  before :each do
    post '/', params
  end

  context 'パラメータが数字のみの場合' do
    context '123' do
      let :text do
        '123'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context '0123456789' do
      let :text do
        '0123456789'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータに数字以外が含まれている場合' do
    context '12345a' do
      let :text do
        '12345a'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'いろはにほへと' do
      let :text do
        'いろはにほへと'
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
