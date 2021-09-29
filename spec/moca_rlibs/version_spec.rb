# frozen_string_literal: true

require 'moca_rlibs'

RSpec.describe 'MocaRlibs::VERSION' do
  subject do
    MocaRlibs::VERSION
  end

  it 'バージョンが取得できること' do
    expect(subject).not_to be nil
  end
end
