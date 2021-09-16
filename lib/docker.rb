# frozen_string_literal: true

# Docker関連の機能を纏めたモジュール
class Docker
  @running_on_docker = File.exist?('/.dockerenv')

  # Dockerコンテナ内かどうかをチェックする。
  #
  # @return [Boolean] Dockerコンテナ内であればtrueを返す。
  def self.running_on_docker?
    @running_on_docker
  end
end
