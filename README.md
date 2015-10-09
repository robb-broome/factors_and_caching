# Factors and Caching

## factors and multiples
There are two operations reqired: 

- For each value in the input, list the other items that are it's factors (except for itself)
- For each value in the input, list the other items that are multiples (except for itself)
These two requirements will be tagged with an `action name` that will be a part of the cache key.

## questions

1. What if you were to cache the calculation, for example in the file system.  What would an example implementationof the cache look like?  By cache I mean, given an array input, skip the calculation of the output if you have already calculated the output at least once already.

  - Calculate a predictable, unique key for the input array `[10, 5, 2, 20]` combined with the `action_name`
	  - flatten out the array (array.sort.join.to_s)
	  - calculate the SHA256 hexdigest of the  action + the array
  - Look for an item in the cache with that key. If it is there, return it.
  - If it's not in the cache, serialize the result of the calculation and write it to the cache under the calculated key.
  - This way there is one cache entry for each unique set of input elements and each operation.

  - This may be the fastest method, since the factors of an item in the input list are constrained by the other values in the input list. 

  - Other schemes may include saving the individual entries separately

2. performance of the caching implementation
	3. Run the cached versus the non-cached 100,000 times compared (just run `test/benchmarks.rb` ).
		
		```
		cache v no cache
	                 user     system      total        real
	cache on  23.970000   1.260000  25.230000 ( 25.240241)
	cache off  0.740000   0.000000   0.740000 (  0.749366)
	```
	
	The cached version is about 34 times slower! (probably due to file IO versus computation.
	
	How to make it more performant?
	
	- Persist the cache object (it is curently recreated for every iteration)
	- Persist the store object (also recreated every time)
	- Cache to redis or memcached to avoid file IO.

	
3. Reversing the functionality. This is what required having the `action_name` added to the cache key. This way, any number of different computation results can be cached.

4. Similar results with cache and no cache. See the tests.


