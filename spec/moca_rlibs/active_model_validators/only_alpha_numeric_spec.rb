# frozen_string_literal: true

require 'moca_rlibs'
require 'active_model/validations'

RSpec.describe ActiveModel::Validations::OnlyAlphaNumericValidator do
  class OnlyAlphaNumericUserModel
    include ActiveModel::Validations

    attr_accessor :user_name

    validates :user_name, only_alpha_numeric: true
  end

  let :user do
    OnlyAlphaNumericUserModel.new
  end

  context '値がnilの場合' do
    it 'バリデーションが通ること' do
      user.user_name = nil

      expect(user).to be_valid
    end
  end

  context '値が空の文字列の場合' do
    it 'バリデーションが通ること' do
      user.user_name = ''

      expect(user).to be_valid
    end
  end

  context '値が正しい場合' do
    it 'バリデーションが通ること' do
      user.user_name = 'helloworld12345'

      expect(user).to be_valid
    end
  end

  context '値が不正な場合' do
    it 'バリデーションが通らないこと' do
      user.user_name = 'hello-world-12345'

      expect(user).not_to be_valid
    end
  end
end
