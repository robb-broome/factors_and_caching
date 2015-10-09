class Factor

  attr_reader :sample

  def initialize test_set
    @sample = test_set
  end

  def factor_list
    {}.tap do |ans|
      sample.each do |i|
        ans[i] =  factors_of(i, sample)
      end
    end
  end

  private

  def factors_of i, list
      (list - [i]).map do |test|
        test if (i % test == 0)
      end.compact
  end
end
