# Copyright (C) 2016  Ruby-GNOME2 Project Team
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

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
