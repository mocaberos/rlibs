# frozen_string_literal: true

module MocaRlibs
  # CodeBuild関連の機能を纏めたモジュール
  class CodeBuild
    # CodeBuild上で"直接"実行されているかを判別する。
    #
    # @return [Boolean] CodeBuild上で"直接"実行されている場合はtrueを返す。
    def self.running_on_codebuild?
      @running_on_codebuild ||= !ENV['CODEBUILD_BUILD_ID'].nil?
    end
  end
end
