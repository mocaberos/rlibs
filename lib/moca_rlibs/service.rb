# frozen_string_literal: true

module MocaRlibs
  # Rails用サービス層の導入
  class Service
    attr_reader :result

    def initialize(*_args, **_kwargs, &_block)
      raise NotImplementedError, "#{self.class}##{__method__} was not implemented"
    end

    # サービスをインスタンス化して処理を実行する
    # 与えられたパラメータを使い、クラスをインスタンス化して、処理を実行する。
    # 処理結果は　@result　に格納される。
    # @return [Service] サービスのインスタンス
    def self.call!(*args, **kwargs, &block)
      instance = new(*args, **kwargs, &block)
      instance.instance_variable_set(:@result, instance.call!)
      instance
    end

    # サービスの処理を実行し結果を返す
    # @abstract        継承してサービスの処理を実装する
    # @return [Object] 処理結果
    def call!
      raise NotImplementedError, "#{self.class}##{__method__} was not implemented"
    end
  end
end
