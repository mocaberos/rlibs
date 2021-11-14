# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # GatewayTimeout (Grape例外拡張)
    class GatewayTimeout < Base
      def initialize
        super(message: '504 Gateway Timeout', status: 504)
      end
    end
  end
end
