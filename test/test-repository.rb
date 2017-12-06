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

class TestRepository < Test::Unit::TestCase
  def setup
    @path = File.expand_path(File.dirname(__FILE__))
    FileUtils.mkdir_p("#{@path}/non_bare_repo/test")
    @url = "https://github.com/ruby-gnome2/ggit.git"
  end

  def test_repository_init_non_bare_repository
    dir = Gio::File.open(:path => "#{@path}/non_bare_repo/test")
    Ggit::Repository.init_repository(dir, false)
    assert(File.exist?(@path + "/non_bare_repo/test/.git/config"))
  end

  def test_repository_init_bare_repository
    dir = Gio::File.open(:path => "#{@path}/bare_repo/test/.git")
    repo = Ggit::Repository.init_repository(dir, true)
    assert(File.exist?(@path + "/bare_repo/test/.git/config"))
    assert(repo.empty?)
  end

  def test_repository_clone
    destination = Gio::File.open(:path => "#{@path}/ggit-clone")
    repo = Ggit::Repository.clone(@url, destination)
    assert(File.exist?(@path + "/ggit-clone/.git/config"))
    assert_false(repo.empty?)
    assert_false(repo.bare?)
  end

  def test_repository_bare_clone
    options = Ggit::CloneOptions.new(:bare => true)
    destination = Gio::File.open(:path => "#{@path}/ggit-clone-bare")
    repo = Ggit::Repository.clone(@url, destination, options)
    assert(File.exist?(@path + "/ggit-clone-bare/config"))
    assert_false(repo.empty?)
    assert(repo.bare?)
  end

  def test_repository_checkout_clone
    options = Ggit::CloneOptions.new(:checkout_branch => "master")
    destination = Gio::File.open(:path => "#{@path}/ggit-clone-checkout")
    repo = Ggit::Repository.clone(@url, destination, options)
    assert(File.exist?(@path + "/ggit-clone-checkout/.git/config"))
    assert_false(repo.empty?)
  end

  def cleanup
    FileUtils.rm_rf("#{@path}/non_bare_repo")
    FileUtils.rm_rf("#{@path}/bare_repo")
    FileUtils.rm_rf("#{@path}/ggit-clone")
    FileUtils.rm_rf("#{@path}/ggit-clone-bare")
    FileUtils.rm_rf("#{@path}/ggit-clone-checkout")
  end
end
