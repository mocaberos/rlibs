# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # RetryRequired (Grape例外拡張)
    class RetryRequired < Base
      def initialize
        super(message: '418 Retry Required', status: 418)
      end
    end
  end
end
