# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/lib/grape/extra_validators/minimum_value.rb

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # 数値の最小値をチェック
  class Min < Grape::Validations::Validators::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      minimum_value = @option.instance_of?(Proc) ? @option.call(params) : @option
      return if minimum_value.blank?

      value = params[attr_name].to_i
      return if value >= minimum_value

      message = "must be equal to or above #{minimum_value}"

      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
