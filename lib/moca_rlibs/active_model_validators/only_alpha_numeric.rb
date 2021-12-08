# frozen_string_literal: true

require 'active_model'
require 'active_support/all'

module ActiveModel::Validations
  # 文字列が半角英数字のみであることをチェックする
  class OnlyAlphaNumericValidator < ActiveModel::EachValidator
    def validate_each(record, _attribute, value)
      return if value.blank?

      value = value.presence.to_s
      return if value.match?(/\A[a-zA-Z0-9]*\z/)

      record.errors.add('contain invalid characters (only numbers and alphabets)')
    end
  end
end
