# frozen_string_literal: true

# @see https://github.com/jagaapple/grape-extra_validators/blob/master/lib/grape/extra_validators/length.rb

require 'active_support/all'
require 'grape'

module MocaRlibs::GrapeValidators
  # 文字列の長さチェック
  class Length < Grape::Validations::Validators::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      # `to_s` is for Symbol.
      parameter = params[attr_name].presence.to_s
      if @option.instance_of?(Range)
        return if @option.include?(parameter.length)

        message = "must be #{@option.first} to #{@option.last} characters long"
        raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end

      return if parameter.length == @option

      unit = 'character'.pluralize(@option)
      message = "must be #{@option} #{unit} long"
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end
  end
end
