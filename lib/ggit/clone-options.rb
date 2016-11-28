module Ggit
  class CloneOptions
    alias_method :initialize_raw, :initialize

    def initialize(options)
      bare = options[:bare] || false
      checkout_branch = options[:checkout_branch] || nil

      initialize_raw
      set_is_bare(bare) if bare
      set_checkout_branch(checkout_branch) if checkout_branch
    end
  end
end
