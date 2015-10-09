require 'benchmark'
Dir[File.expand_path(File.join('../../lib/*.rb'), __FILE__)].each { |file| require file }

puts 'cache v no cache'

sample = [10, 5, 2, 20]
iterations = 100_000

Benchmark.bm do |x|
  x.report('cache on') {iterations.times do; Factor.new(sample).factor_list; end }
  x.report('cache off') {iterations.times do; Factor.new(sample,cache_disabled: true).factor_list; end }
end
