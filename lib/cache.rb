class Cache
  require 'digest'

  attr_reader :test_set, :store, :disabled
  def initialize test_set, disabled: false
    @test_set = test_set
    @disabled = disabled
    @store = Store.new
  end

  def read action
    return nil if disabled
    store.read key(action)
  end

  def write action, val
    return val if disabled
    store.write key(action), val
  end

  private

  def key action
    Digest::SHA256.hexdigest(action.to_s << test_set.sort.join.to_s)
  end
end
