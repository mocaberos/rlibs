# frozen_string_literal: true

require 'active_model'
require 'active_support/all'

module ActiveModel::Validations
  # 文字列が数字のみであることをチェックする
  class OnlyNumbersValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank?

      value = value.presence.to_s
      return if value.match?(/\A[0-9]*\z/)

      record.errors[attribute] << 'contain invalid characters (only numbers)'
    end
  end
end
