# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::OnlyPrintable do
  module GrapeValidationsSpec
    module OnlyPrintableValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, only_printable: true
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::OnlyPrintableValidatorSpec::API
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

  context 'パラメータが正しい場合' do
    context '123abc' do
      let :text do
        '123abc'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context '!"#$%&\'()*+,-./:;<=>?@[\]^_`{|}~' do
      let :text do
        '!"#$%&\'()*+,-./:;<=>?@[\]^_`{|}~'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータが正しくない場合' do
    context 'aaa\nbbb' do
      let :text do
        "aaa\nbbb"
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'aaa\tbbb' do
      let :text do
        "aaa\tbbb"
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
