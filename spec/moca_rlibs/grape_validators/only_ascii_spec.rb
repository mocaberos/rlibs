# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::OnlyASCII do
  module GrapeValidationsSpec
    module OnlyASCIIValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, only_ascii: true
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::OnlyASCIIValidatorSpec::API
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

  context 'パラメータがASCII文字のみの場合' do
    context 'asdf' do
      let :text do
        'asdf'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context '!%@&#(@)#&@SF#^@SA)SA' do
      let :text do
        '!%@&#(@)#&@SF#^@SA)SA'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータにASCII以外の文字が含まれている場合' do
    context 'aaaあaaa' do
      let :text do
        'aaaあaaa'
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
