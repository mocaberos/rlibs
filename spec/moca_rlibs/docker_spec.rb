# frozen_string_literal: true

require 'moca_rlibs'

RSpec.describe MocaRlibs::Docker do
  describe '#running_on_docker?' do
    subject do
      described_class.running_on_docker?
    end

    context 'Docker外で実行された場合' do
      before :each do
        allow(File).to receive(:exist?).and_return(false)
      end

      it 'falseを返すこと' do
        expect(subject).to eq(false)
      end
    end

    context 'Docker内で実行された場合' do
      before :each do
        allow(File).to receive(:exist?).and_return(true)
      end

      it 'trueを返すこと' do
        expect(subject).to eq(true)
      end
    end
  end
end
