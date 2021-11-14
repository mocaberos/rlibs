# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # NotFound (Grape例外拡張)
    class NotFound < Base
      def initialize
        super(message: '404 NotFound', status: 404)
      end
    end
  end
end
