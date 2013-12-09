require "test/unit"

require_relative "../lib/octo_extractor"

class TestOctoExtractor < Test::Unit::TestCase

  def test_octokit_ruby_source_filepaths
  	filepath = OctoExtractor.octokit_ruby_source_filepaths.first
    assert filepath.include? "octokit"
    assert_equal ".rb", filepath[-3..-1]
  end

end
