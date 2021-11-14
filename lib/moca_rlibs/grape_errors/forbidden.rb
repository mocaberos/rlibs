# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # Forbidden (Grape例外拡張)
    class Forbidden < Base
      def initialize
        super(message: '403 Forbidden', status: 403)
      end
    end
  end
end
