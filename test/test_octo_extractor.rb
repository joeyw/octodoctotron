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
      selector: '#meta',
      method_name: 'meta'
    }]
    data = OctoExtractor.process get_source_file('client/meta.rb')
    assert_equal expected_data, data
  end

  def test_extracts_multiple_url_connections
    expected_data = [{
      selector: '#list-statuses-for-a-specific-ref',
      method_name: 'statuses'
    }, {
      selector: '#create-a-status',
      method_name: 'create_status'
    }]

    data = OctoExtractor.process get_source_file('client/statuses.rb')
    assert_equal expected_data, data
  end

  def test_exclude_methods_without_documented_urls
    data = OctoExtractor.process get_source_file('client/users.rb')
    assert data.select { |entry| entry[:selector].nil? }.empty?
  end

  def test_exclude_urls_without_hashes
    data = OctoExtractor.process get_source_file('octokit/client.rb')
    assert data.empty?
  end

  private

  def get_source_file(file_name)
    OctoExtractor.filepaths.select { |fp|
      fp.match Regexp.quote file_name
    }.first
  end
end
