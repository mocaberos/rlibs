# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # BadRequest (Grape例外拡張)
    class BadRequest < Base
      def initialize
        super(message: '400 Bad Request', status: 400)
      end
    end
  end
end
