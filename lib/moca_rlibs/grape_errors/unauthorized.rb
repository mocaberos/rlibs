# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # Unauthorized (Grape例外拡張)
    class Unauthorized < Base
      def initialize
        super(message: '401 Unauthorized', status: 401)
      end
    end
  end
end
