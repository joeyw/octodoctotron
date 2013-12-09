module OctoExtractor
  class << self

    # List all the Octokit ruby source filepaths for the latest installed
    #   version.
    #
    # @return [Array<String>] List of Octokit source ruby filepaths
    def octokit_ruby_source_filepaths
      `gem content octokit`.split("\n").
        select { |filepath| filepath[-3..-1] == ".rb" }
    end

  end
end
