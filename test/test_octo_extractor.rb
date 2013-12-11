require "test/unit"

require_relative "../lib/octo_extractor"

class TestOctoExtractor < Test::Unit::TestCase

  def test_octokit_ruby_source_filepaths
  	filepath = OctoExtractor.filepaths.first
    assert filepath.include? "octokit"
    assert_equal ".rb", filepath[-3..-1]
  end

  def test_extact_api_url_and_method_name_from_simple_source
  	expected_data = [{
  		api_url: 'http://developer.github.com/v3/meta/#meta',
  		method_name: 'meta'
  	}]
  	data = OctoExtractor.process('test/fixtures/octokit_meta.rb')

  	assert_equal expected_data, data
  end

end
