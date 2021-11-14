# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/spec/grape/extra_validators/maximum_value_spec.rb

require 'grape'
require 'moca_rlibs'

RSpec.describe MocaRlibs::GrapeValidators::Max do
  module GrapeValidationsSpec
    module MaxValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :static_number, type: Integer, max: 10
          optional :maximum_value_for_proc_number, type: Integer, allow_blank: false
          optional :proc_number, type: Integer, max: ->(params) { params[:maximum_value_for_proc_number] + 1 }
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::MaxValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    {
      static_number:                 static_number,
      maximum_value_for_proc_number: maximum_value_for_proc_number,
      proc_number:                   proc_number
    }.compact
  end

  let :static_number do
    nil
  end

  let :maximum_value_for_proc_number do
    nil
  end

  let :proc_number do
    nil
  end

  before :each do
    post '/', params
  end

  context 'オプションに数値が指定された場合' do
    context 'パラメータが最大値より小さい場合' do
      let :static_number do
        9
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが最大値と等しい場合' do
      let :static_number do
        10
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが最大値より大きい場合' do
      let :static_number do
        11
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end
  end

  context 'オプションにProcが指定された場合' do
    context 'パラメータが最大値より小さい場合' do
      let :maximum_value_for_proc_number do
        10
      end

      let :proc_number do
        10
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが最大値と等しい場合' do
      let :maximum_value_for_proc_number do
        10
      end

      let :proc_number do
        11
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが最大値より大きい場合' do
      let :maximum_value_for_proc_number do
        10
      end

      let :proc_number do
        12
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end
  end

  context 'パラメータがnilの場合' do
    let :params do
      {}
    end

    it '204のステータスコードを返すこと' do
      expect(subject).to eq(204)
    end
  end
end
