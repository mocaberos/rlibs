# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # InternalServerError (Grape例外拡張)
    class InternalServerError < Base
      def initialize
        super(message: '500 Internal Server Error', status: 500)
      end
    end
  end
end
