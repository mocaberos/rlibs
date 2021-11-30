# frozen_string_literal: true

require 'active_model'
require 'active_support/all'

module ActiveModel::Validations
  # 文字列が半角アルファベットのみであることをチェックする
  class OnlyAlphaValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank?

      value = value.presence.to_s
      return if value.match?(/\A[a-zA-Z]*\z/)

      record.errors[attribute] << 'contain invalid characters (only alphabets)'
    end
  end
end
