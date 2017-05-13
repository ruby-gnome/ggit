# Copyright (C) 2017  Ruby-GNOME2 Project Team
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

class TestConfig < Test::Unit::TestCase
  def setup
    @path = File.expand_path(File.dirname(__FILE__))
    FileUtils.mkdir_p("#{@path}/config")
    FileUtils.cp("#{@path}/gitconfig", "#{@path}/config/")
    @config_file_path = "#{@path}/config/gitconfig"
    @file = Gio::File.path(@config_file_path)
    puts @file.path
  end

  def test_new_config_from_file
    conf = Ggit::Config.new(:file => @file)
    user = conf.get_string("user.name")
    assert_equal("name", user)
  end

  def test_new_config
    conf = Ggit::Config.new
    conf.add_file(@file, :local, true)
    user = conf.get_string("user.name")
    assert_equal("name", user)
  end

  def cleanup
    FileUtils.rm_rf("#{@path}/config")
  end
end
