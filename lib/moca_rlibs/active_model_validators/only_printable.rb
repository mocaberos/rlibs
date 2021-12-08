# frozen_string_literal: true

require 'active_model'
require 'active_support/all'

module ActiveModel::Validations
  # 出力可能なアスキー文字のみかどうかをチェックする(半角英数字+一部の記号)
  class OnlyPrintableValidator < ActiveModel::EachValidator
    def validate_each(record, _attribute, value)
      return if value.blank?

      value = value.presence.to_s
      return if value.match?(%r{\A[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]*\z})

      record.errors.add('contain invalid characters (only printable ascii characters)')
    end
  end
end
