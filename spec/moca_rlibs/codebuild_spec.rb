# frozen_string_literal: true

require 'moca_rlibs'

RSpec.describe MocaRlibs::CodeBuild do
  describe '#running_on_codebuild?' do
    subject do
      described_class.running_on_codebuild?
    end

    context 'CodeBuild上で直接実行されていない場合' do
      before :each do
        ENV['CODEBUILD_BUILD_ID'] = nil
      end

      it 'falseを返すこと' do
        expect(subject).to eq(false)
      end
    end

    context 'CodeBuild上で直接実行された場合' do
      before :each do
        ENV['CODEBUILD_BUILD_ID'] = 'some id'
      end

      it 'trueを返すこと' do
        expect(subject).to eq(true)
      end
    end
  end
end
