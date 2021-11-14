# frozen_string_literal: true

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # 出力可能なアスキー文字のみかどうかをチェックする(半角英数字+半角スペース+一部の記号)
  class OnlyPrintable < Grape::Validations::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      # `to_s` is for Symbol.
      parameter = params[attr_name].presence.to_s
      return if parameter.match?(%r{\A[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]*\z})

      message = 'contain invalid characters (only printable ascii characters)'
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
