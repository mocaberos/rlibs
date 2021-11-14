# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::OnlyAlphaNumeric do
  module GrapeValidationsSpec
    module OnlyAlphaNumericValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, only_alpha_numeric: true
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::OnlyAlphaNumericValidatorSpec::API
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

  context 'パラメータが半角英数字のみの場合' do
    context 'abcd123' do
      let :text do
        'abcd123'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'aaaa' do
      let :text do
        'aaaa'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータに半角英数字以外が含まれている場合' do
    context 'aaaa1$' do
      let :text do
        'aaaa1$'
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
