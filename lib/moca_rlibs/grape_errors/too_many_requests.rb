# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # TooManyRequests (Grape例外拡張)
    class TooManyRequests < Base
      def initialize
        super(message: '401 Too Many Requests', status: 429)
      end
    end
  end
end
