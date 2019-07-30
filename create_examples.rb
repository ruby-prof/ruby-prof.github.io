# A silly little test program that finds prime numbers.  It
# is intentionally badly designed to show off the use
# of ruby-prof.
#
# Source from http://people.cs.uchicago.edu/~bomb154/154/maclabs/profilers-lab/

require 'fileutils'

require 'ruby-prof'

gem_path = Gem.loaded_specs['ruby-prof'].full_gem_path
prime_path = File.join(gem_path, 'test', 'prime.rb')
require prime_path

# Generate example reports
def generate_reports(result)
  path = File.join('examples')
  path = File.expand_path(path)
  FileUtils.makedirs(path)
  printer = RubyProf::MultiPrinter.new(result, [:flat, :flat_with_lines, :graph, :graph_html, :call_info, :tree, :stack, :dot])
  printer.print(:path => path, :profile => 'primes')
end

def run
  start = Process.times
  result = RubyProf.profile do
    run_primes(10000)
  end

  generate_reports(result)
end

run