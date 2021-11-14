# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # ServiceUnavailable (Grape例外拡張)
    class ServiceUnavailable < Base
      def initialize
        super(message: '503 Service Unavailable', status: 503)
      end
    end
  end
end
