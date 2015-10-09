require_relative 'test_helper'

describe Factor do
  let(:sample) {[10, 5, 2, 20]}
  let(:answer) { {10 => [5, 2], 5 => [], 2 => [], 20 => [10,5,2]} }
  subject {Factor.new(sample)}

  it 'reports factors' do
    subject.factor_list.must_equal(answer)
  end

end
