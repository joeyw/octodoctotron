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
      selectors: ['#meta'],
      method_name: 'meta'
    }]
    data = OctoExtractor.process get_source_file('client/meta.rb')
    assert_equal expected_data, data
  end

  def test_extracts_multiple_url_connections
    expected_data = [{
      selectors: ['#list-statuses-for-a-specific-ref'],
      method_name: 'statuses'
    }, {
      selectors: ['#create-a-status'],
      method_name: 'create_status'
    }]

    data = OctoExtractor.process get_source_file('client/statuses.rb')
    assert_equal expected_data, data
  end

  def test_exclude_methods_without_documented_urls
    data = OctoExtractor.process get_source_file('client/users.rb')
    assert data.select { |entry| entry[:selectors].nil? }.empty?
  end

  def test_exclude_urls_without_hashes
    data = OctoExtractor.process get_source_file('octokit/client.rb')
    assert data.empty?
  end

  def test_extract_multiple_urls_per_method
    data = OctoExtractor.process get_source_file('client/users.rb')
    user = data.select { |entry| entry[:method_name] == "user" }.first
    assert_equal 2, user[:selectors].length
    assert user[:selectors].index('#get-a-single-user')
    assert user[:selectors].index('#get-the-authenticated-user')
  end

  private

  def get_source_file(file_name)
    OctoExtractor.filepaths.select { |fp|
      fp.match Regexp.quote file_name
    }.first
  end
end
