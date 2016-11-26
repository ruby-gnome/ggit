module Ggit
  class Diff
    alias_method :initialize_raw, :initialize

    def initialize(repo, args)
      old_tree = args[:old_tree]
      new_tree = args[:new_tree]
      index    = args[:index]
      options  = args[:options]
      to_workdir = args[:to_workdir] || false

      if old_tree and new_tree
        initialize_new_tree_to_tree(repo, old_tree, new_tree, options)
      elsif old_tree and index
        initialize_new_tree_to_index(repo, old_tree, index, options)
      elsif index and to_workdir
        initialize_new_index_to_workdir(repo, index, options)
      elsif old_tree and to_workdir
        initialize_new_index_to_workdir(repo, old_tree, options)
      end
    end
  end
end
