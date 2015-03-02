require 'to_octopress'
require 'minitest/autorun'


class ToOctopressTest < Minitest::Unit::TestCase
    def test_to_octopress   
        ToOctopress.to_octopress('shawsome_test',"blogs","updated_at","slug","content","title",File.dirname(__FILE__))
        assert(true,File.file?('to_octopress.zip'))
    end
end