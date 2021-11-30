# frozen_string_literal: true

require 'active_support/all'
require 'grape'
require 'resolv'

module MocaRlibs::GrapeValidators
  # 数値の最小値をチェック
  class IpAddress < Grape::Validations::Base
    def validate_param!(attr_name, params)
      return if !@required && params[attr_name].blank?

      version = @option.instance_of?(Proc) ? @option.call(params) : @option
      value = params[attr_name].presence.to_s
      return if validate_ip(version, value)

      message = "invalid ip format: #{value}"
      raise Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
    end

    private

    def validate_ip(version, value)
      case version
      when :v4
        return true if ::Resolv::IPv4::Regex.match?(value)
      when :v6
        return true if ::Resolv::IPv6::Regex.match?(value)
      else
        return true if ::Resolv::IPv4::Regex.match?(value)
        return true if ::Resolv::IPv6::Regex.match?(value)
      end
      false
    end
  end
end
