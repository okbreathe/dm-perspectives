require 'rubygems'
gem 'test-unit'
require 'test/unit'
require 'shoulda'
require 'rr'
require 'dm-migrations'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'dm-perspectives'

class Test::Unit::TestCase
end
 

