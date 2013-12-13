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
      method_name: 'meta',
      octokit_doc_url: 'Octokit/Client/Meta.html#meta-instance_method',
      doc_paths: ['/v3/meta/']
    }]
    data = OctoExtractor.process get_source_file('client/meta.rb')
    assert_equal expected_data, data
  end

  def test_extracts_multiple_url_connections
    expected_data = [{
      selectors: ['#list-statuses-for-a-specific-ref'],
      method_name: 'statuses',
      octokit_doc_url: "Octokit/Client/Statuses.html#statuses-instance_method",
      doc_paths: ['/v3/repos/statuses/']
    }, {
      selectors: ['#create-a-status'],
      method_name: 'create_status',
      octokit_doc_url: "Octokit/Client/Statuses.html#create_status-instance_method",
      doc_paths: ['/v3/repos/statuses/']
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

  def test_octokit_doc_path
    path = OctoExtractor.octokit_doc_path('lib/octokit/client/users.rb', 'user')
    another_path = OctoExtractor.octokit_doc_path('lib/octokit/client/rate_limit.rb', 'rate_limit_remaining')
    assert_equal "Octokit/Client/Users.html#user-instance_method", path
    assert_equal "Octokit/Client/RateLimit.html#rate_limit_remaining-instance_method", another_path
  end

  private

  def get_source_file(file_name)
    OctoExtractor.filepaths.select { |fp|
      fp.match Regexp.quote file_name
    }.first
  end
end
