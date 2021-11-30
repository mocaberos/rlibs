# frozen_string_literal: true

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::IpAddress do
  module GrapeValidationsSpec
    module IpAddressValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :ip,   type: String, ip_address: true
          optional :ipv4, type: String, ip_address: :v4
          optional :ipv6, type: String, ip_address: :v6
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::IpAddressValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    {
      ip:   ip,
      ipv4: ipv4,
      ipv6: ipv6
    }
  end

  let :ip do
    nil
  end

  let :ipv4 do
    nil
  end

  let :ipv6 do
    nil
  end

  before :each do
    post '/', params
  end

  context 'パラメータ正しい場合' do
    context 'ip' do
      let :ip do
        '127.0.0.1'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'v4' do
      let :ipv4 do
        '127.0.0.1'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'v6' do
      let :ipv6 do
        'dead:beaf::dead:beaf'
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'パラメータ正しくない場合' do
    context 'ip' do
      let :ip do
        'asdf'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'v4' do
      let :ipv4 do
        'dead:beaf::dead:beaf'
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'v6' do
      let :ipv6 do
        '127.0.0.1'
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
