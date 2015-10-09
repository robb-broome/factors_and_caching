require_relative 'test_helper'

describe :factor_app do
  let(:sample) {[10, 5, 2, 20]}
  let(:factor_list_answer) { {10 => [5, 2], 5 => [], 2 => [], 20 => [10,5,2]} }
  let(:multiple_list_answer) { {10 => [20], 5 => [10,20], 2 => [10, 20], 20 => []} }
  let(:key) {:data}

  describe :with_cache do
    let(:store) {Store.new}
    before :each do
      store.clear
    end

    describe Factor do
      subject {Factor.new(sample)}

      it 'reports factors' do
        subject.factor_list.must_equal(factor_list_answer)
      end

      it 'reports the same answer when cached' do
        subject.factor_list
        subject.factor_list.must_equal(factor_list_answer)
      end

    end

    describe Multiple do
      subject {Multiple.new(sample)}

      it 'reports multiples' do
        subject.multiple_list.must_equal(multiple_list_answer)
      end

      it 'reports the same answer when cached' do
        # not cached: first run
        subject.multiple_list
        # second run is cached
        subject.multiple_list.must_equal(multiple_list_answer)
      end

    end

    describe Store do
      subject {store}

      it 'returns the written value' do
        subject.write(key, factor_list_answer).must_equal factor_list_answer
      end

      it 'persists a complex value' do
        subject.write key, factor_list_answer

        reloaded_store = Store.new
        subject.read(key).must_equal factor_list_answer
      end

      it 'clears the key' do
        store.write key, factor_list_answer
        store.clear
        store.read(key).must_equal(nil)
      end

      it 'clears the store' do
        store.write key, factor_list_answer
        store.clear
        store.attrs.must_equal({})
      end
    end

    describe Cache do
      let(:cache) {Cache.new sample}
      it 'persists' do
        cache.write :action, factor_list_answer

      end
    end
  end
end
