# frozen_string_literal: true

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # 文字列が数字のみであることをチェックする
  class OnlyNumbers < Grape::Validations::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      # `to_s` is for Symbol.
      parameter = params[attr_name].presence.to_s
      return if parameter.match?(/\A[0-9]*\z/)

      message = 'contain non-ascii characters'
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
