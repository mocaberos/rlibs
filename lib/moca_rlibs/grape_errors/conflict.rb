# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # Conflict (Grape例外拡張)
    class Conflict < Base
      def initialize
        super(message: '409 Conflict', status: 409)
      end
    end
  end
end
