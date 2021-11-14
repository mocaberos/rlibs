# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/spec/grape/extra_validators/minimum_value_spec.rb

RSpec.describe MocaRlibs::GrapeValidators::Max do
  module GrapeValidationsSpec
    module MinValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :static_number, type: Integer, min: 10
          optional :minimum_value_for_proc_number, type: Integer, allow_blank: false
          optional :proc_number, type: Integer, min: ->(params) { params[:minimum_value_for_proc_number] - 1 }
        end
        post '/' do
          body false
        end
      end
    end
  end

  def app
    GrapeValidationsSpec::MinValidatorSpec::API
  end

  subject do
    last_response.status
  end

  let :params do
    {
      static_number:                 static_number,
      minimum_value_for_proc_number: minimum_value_for_proc_number,
      proc_number:                   proc_number
    }.compact
  end

  let :static_number do
    nil
  end

  let :minimum_value_for_proc_number do
    nil
  end

  let :proc_number do
    nil
  end

  before :each do
    post '/', params
  end

  context 'オプションに数値が設定された場合' do
    context 'パラメータが最小値よりも小さい場合' do
      let :static_number do
        9
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'パラメータが最小値に等しい場合' do
      let :static_number do
        10
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが最小値よりも大きい場合' do
      let :static_number do
        11
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end
  end

  context 'オプションにProcが設定された場合' do
    context 'パラメータが最小値よりも小さい場合' do
      let :minimum_value_for_proc_number do
        12
      end

      let :proc_number do
        10
      end

      it '400のステータスコードを返すこと' do
        expect(subject).to eq(400)
      end
    end

    context 'パラメータが最小値に等しい場合' do
      let :minimum_value_for_proc_number do
        12
      end

      let :proc_number do
        11
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
      end
    end

    context 'パラメータが最小値よりも大きい場合' do
      let :minimum_value_for_proc_number do
        12
      end

      let :proc_number do
        12
      end

      it '204のステータスコードを返すこと' do
        expect(subject).to eq(204)
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
