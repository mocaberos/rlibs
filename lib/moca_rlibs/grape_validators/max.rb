# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/lib/grape/extra_validators/maximum_value.rb

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # 数値の最大値をチェック
  class Max < Grape::Validations::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      maximum_value = @option.instance_of?(Proc) ? @option.call(params) : @option
      return if maximum_value.blank?

      value = params[attr_name].to_i
      return if value <= maximum_value

      message = "must be equal to or below #{maximum_value}"

      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
