# frozen_string_literal: true

require 'active_model'
require 'active_support/all'
require 'resolv'

module ActiveModel::Validations
  # IPアドレスのフォーマットをチェックする
  class IpValidator < ::ActiveModel::EachValidator
    PERMITTED_VERSION = %i[v4 v6].freeze

    def initialize(options)
      options[:version] ||= %i[v4 v6]
      options[:version] = Array(options[:version])
      super
    end

    def validate_each(record, attribute, value)
      return if value.blank?

      value = value.presence.to_s
      return if options[:version].include?(:v4) && ::Resolv::IPv4::Regex.match?(value)
      return if options[:version].include?(:v6) && ::Resolv::IPv6::Regex.match?(value)

      record.errors.add('invalid ip format')
    end
  end
end
