class Multiple

  attr_reader :test_set, :cache

  def initialize test_set
    @cache = Cache.new test_set
    @test_set = test_set
  end

  def multiple_list
    cache.read(action) || cache.write(action, multiple)
  end

  private

  def action
    self.class.name
  end

  def multiple
    {}.tap do |ans|
      test_set.each do |i|
        ans[i] =  multiples_of(i, test_set)
      end
    end
  end

  def multiples_of i, list
      (list - [i]).map do |test|
        test if (test % i == 0)
      end.compact
  end
end

