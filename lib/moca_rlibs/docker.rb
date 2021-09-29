# frozen_string_literal: true

module MocaRlibs
  # Docker関連の機能を纏めたモジュール
  class Docker
    # Dockerコンテナ内かどうかをチェックする。
    #
    # @return [Boolean] Dockerコンテナ内であればtrueを返す。
    def self.running_on_docker?
      @running_on_docker ||= File.exist?('/.dockerenv')
    end
  end
end
