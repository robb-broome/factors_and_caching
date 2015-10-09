class Factor

  attr_reader :test_set, :cache

  def initialize test_set, cache_disabled: false
    @cache = Cache.new test_set, disabled: cache_disabled
    @test_set = test_set
  end

  def factor_list
    cache.read(action) || cache.write(action, factor)
  end

  private

  def action
    self.class.name
  end

  def factor
    {}.tap do |ans|
      test_set.each do |i|
        ans[i] =  factors_of(i, test_set)
      end
    end
  end

  def factors_of i, list
      (list - [i]).map do |test|
        test if (i % test == 0)
      end.compact
  end
end
