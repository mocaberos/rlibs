# frozen_string_literal: true

# カーネルモジュールの拡張
module Kernel
  # pythonのpassと同様、「何もしないこと」を明示的に示すため
  def pass
    # pass
  end
end
