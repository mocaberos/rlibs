# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::Email do
  module GrapeValidationsSpec
    module EmailValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :email, type: String, email: true
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::EmailValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    {
      email: email
    }
  end

  let :email do
    nil
  end

  before :each do
    post '/', params
  end

  context 'パラメータが正しいメールアドレスの場合' do
    context 'admin@example.com' do
      let :email do
        'admin@example.com'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'hoge@hoge.com' do
      let :email do
        'hoge@hoge.com'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータが正しいメールアドレスではない場合' do
    context 'fasd@fas@asd' do
      let :email do
        'fasd@fas@asd'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'hoge' do
      let :email do
        'hoge'
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
