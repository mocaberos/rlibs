# frozen_string_literal: true

require 'moca_rlibs'
require 'active_model/validations'

RSpec.describe ActiveModel::Validations::IpValidator do
  class IpModel
    include ActiveModel::Validations

    attr_accessor :ip

    validates :ip, ip: true
  end

  class Ipv4Model
    include ActiveModel::Validations

    attr_accessor :ip

    validates :ip, ip: { version: :v4 }
  end

  class Ipv6Model
    include ActiveModel::Validations

    attr_accessor :ip

    validates :ip, ip: { version: :v6 }
  end

  let :ip do
    IpModel.new
  end

  let :ipv4 do
    Ipv4Model.new
  end

  let :ipv6 do
    Ipv6Model.new
  end

  context '値がnilの場合' do
    it 'バリデーションが通ること' do
      ip.ip = nil

      expect(ip).to be_valid
    end

    it 'バリデーションが通ること(v4)' do
      ipv4.ip = nil

      expect(ipv4).to be_valid
    end

    it 'バリデーションが通ること(v6)' do
      ipv6.ip = nil

      expect(ipv6).to be_valid
    end
  end

  context '値が空の文字列の場合' do
    it 'バリデーションが通ること' do
      ip.ip = ''

      expect(ip).to be_valid
    end

    it 'バリデーションが通ること(v4)' do
      ipv4.ip = ''

      expect(ipv4).to be_valid
    end

    it 'バリデーションが通ること(v6)' do
      ipv6.ip = ''

      expect(ipv6).to be_valid
    end
  end

  context '値が正しい場合' do
    it 'バリデーションが通ること' do
      ip.ip = '127.0.0.1'

      expect(ip).to be_valid
    end

    it 'バリデーションが通ること(v4)' do
      ipv4.ip = '127.0.0.1'

      expect(ipv4).to be_valid
    end

    it 'バリデーションが通ること(v6)' do
      ipv6.ip = 'dead:beaf::dead:beaf'

      expect(ipv6).to be_valid
    end
  end

  context '値が正しくない場合' do
    it 'バリデーションが通らないこと' do
      ip.ip = 'asdf'

      expect(ip).not_to be_valid
    end

    it 'バリデーションが通らないこと(v4)' do
      ipv4.ip = 'dead:beaf::dead:beaf'

      expect(ipv4).not_to be_valid
    end

    it 'バリデーションが通らないこと(v6)' do
      ipv6.ip = '127.0.0.1'

      expect(ipv6).not_to be_valid
    end
  end
end
