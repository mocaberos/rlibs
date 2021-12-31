# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/lib/grape/extra_validators/start_with.rb

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # 文字列の先頭をチェック
  class StartsWith < Grape::Validations::Validators::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      start_with_values = @option.instance_of?(Array) ? @option : [@option]

      # `to_s` is for Symbol.
      parameter = params[attr_name].presence.to_s
      is_valid = start_with_values.any? { |value| parameter.starts_with?(value.to_s) }
      return if is_valid

      allow_values = start_with_values.map { |value| "\"#{value}\"" }
      allow_values[allow_values.length - 1] = "or #{allow_values.last}" if allow_values.length > 1
      message = "must start with #{allow_values.join(', ')}"
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
