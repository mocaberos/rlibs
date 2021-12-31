# frozen_string_literal: true

require 'active_support/all'
require 'grape'
require 'active_model'
require 'email_validator'

module MocaRlibs::GrapeValidators
  # メールアドレスのフォーマットチェック(RFC-2822, RFC-5321)
  class EmailRFC < Grape::Validations::Validators::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      # `to_s` is for Symbol.
      parameter = params[attr_name].presence.to_s
      return if EmailValidator.valid?(parameter, { allow_nil: true, mode: :rfc, require_fqdn: false })

      message = 'invalid email format'
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
