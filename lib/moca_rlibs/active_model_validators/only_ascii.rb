# frozen_string_literal: true

require 'active_model'
require 'active_support/all'

module ActiveModel::Validations
  # アスキー文字のみを許可する
  class OnlyAsciiValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank?

      value = value.presence.to_s
      return if value.match?(/\A[\u0000-\u007F]*\z/)

      record.errors[attribute] << 'contain non-ascii characters'
    end
  end
end
