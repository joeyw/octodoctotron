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
    #      selectors: ["#meta"],
    #      method_name: "meta"
    #    }]
    #
    # @param filepath [String] Path to an Octokit ruby source file.
    # @return [Array<Hash>] list of relations with :selectors and :method_name.
    def process(filepath)
      data = []
      urls = []
      method_name = nil

      File.read(filepath).each_line do |line|
        url = line.split(" ")
          .select { |string| string =~ /developer\.github/ }
          .first
        urls.push url if !url.nil? && !url.empty? && url.include?("#")

        if line.include? "def "
          line_words = line.split(" ")
          method_name = line_words[line_words.index("def") + 1]
          if method_name.include?("(")
            method_name = method_name.split("(")[0]
          end

          if !urls.empty?
            urls.map! { |url| "##{url.split('#')[1]}" }
            data.push({ 
              selectors: urls, 
              method_name: method_name,
              octokit_doc_url: octokit_doc_path(filepath, method_name)
            })
          end
          urls = []
          method_name = nil
        end
      end
      data
    end

    # Scrap together a url for the octokit docs
    #
    # Input:
    #   filepath: '....octokit-2.6.3/lib/octokit/client/users.rb'
    #   method_name: 'user_authenticated?'
    #
    # Output:
    #   Octokit/Authentication.html#user_authenticated?-instance_method
    #
    # @param filepath [String] source file path for the method we are linking
    # @param method_name [String] method name we are linking
    # @return [String] relative path to method in octokit yard docs
    def octokit_doc_path(filepath, method_name)
      base = filepath[filepath.index('lib/octokit')+4..-1].gsub(/\.rb/, '')
        .split('/')
        .map { |name| name.split("_").each(&:capitalize!).join }
        .join('/')
      "#{base}.html##{method_name}-instance_method"
    end

  end
end
