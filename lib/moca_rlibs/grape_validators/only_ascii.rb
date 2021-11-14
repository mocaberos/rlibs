# frozen_string_literal: true

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # アスキー文字のみを許可する
  class OnlyASCII < Grape::Validations::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      # `to_s` is for Symbol.
      parameter = params[attr_name].presence.to_s
      return if parameter.match?(/\A[\u0000-\u007F]*\z/)

      message = 'contain non-ascii characters'
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
