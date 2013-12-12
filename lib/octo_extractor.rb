module OctoExtractor
  class << self

    # List all the Octokit ruby source filepaths for the latest installed
    #   version.
    #
    # @return [Array<String>] List of Octokit source ruby filepaths
    def filepaths
      `gem content octokit`.split("\n").
        select { |filepath| filepath[-3..-1] == ".rb" }
    end

    # Extract GitHub API documentation links and the methods associated with it
    # from an Octokit source code ruby file.
    #
    # Example:
    #
    # Octokit meta.rb source file:
    #
    # module Octokit
    #   class Client
    #
    #     # Methods for the Meta API
    #     #
    #     # @see http://developer.github.com/v3/meta/
    #     module Meta
    #
    #       # Get meta information about GitHub.com, the service.
    #       # @see http://developer.github.com/v3/meta/#meta
    #       # @return [Sawyer::Resource] Hash with meta information.
    #       # @example Get GitHub meta information
    #       #   @client.github_meta
    #       def meta(options = {})
    #         get "meta", options
    #       end
    #       alias :github_meta :meta
    #
    #     end
    #   end
    # end
    #
    # Output
    #
    # => [{
    #      api_url: "http://developer.github.com/v3/meta/#meta",
    #      method_name: "meta"
    #    }]
    #
    # @param filepath [String] Path to an Octokit ruby source file.
    # @return [Array<Hash>] list of relations with :api_url and :method_name.
    def process(filepath)
      data = []
      last_url = nil
      method_name = nil

      File.read(filepath).each_line do |line|
        url = line.split(" ")
          .select { |string| string =~ /developer\.github/ }
          .first
        last_url = url if !url.nil? && !url.empty? && url.include?("#")

        if line.include? "def "
          line_words = line.split(" ")
          method_name = line_words[line_words.index("def") + 1]
          if method_name.include?("(")
            method_name = method_name.split("(")[0]
          end

          if !last_url.nil?
            data.push({ api_url: last_url, method_name: method_name })
          end
          last_url = nil
          method_name = nil
        end
      end
      data
    end

  end
end
