# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # BadGateway (Grape例外拡張)
    class BadGateway < Base
      def initialize
        super(message: '502 Bad Gateway', status: 502)
      end
    end
  end
end
