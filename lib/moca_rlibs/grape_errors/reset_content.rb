# frozen_string_literal: true

require 'grape'

module Grape
  module Exceptions
    # ResetContent (Grape例外拡張)
    class ResetContent < Base
      def initialize
        super(message: '205 ResetContent', status: 205)
      end
    end
  end
end
