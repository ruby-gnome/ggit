class TestRepository < Test::Unit::TestCase
  def setup
    @path = File.expand_path(File.dirname(__FILE__))
    FileUtils.mkdir_p("#{@path}/non_bare_repo/test")
  end

  def test_repository_init_non_bare_repository
    dir = Gio::File.path("#{@path}/non_bare_repo/test")
    Ggit::Repository.init_repository(dir, false)
    assert(File.exist?(@path + "/non_bare_repo/test/.git/config"))
  end

  def test_repository_init_bare_repository
    dir = Gio::File.path("#{@path}/bare_repo/test/.git")
    Ggit::Repository.init_repository(dir, true)
    assert(File.exist?(@path + "/bare_repo/test/.git/config"))
  end

  def test_repository_clone
    url = "https://github.com/ruby-gnome2/ggit.git"
    destination = Gio::File.path("#{@path}/ggit-clone")
    Ggit::Repository.clone(url, destination)
    assert(File.exist?(@path + "/ggit-clone/.git/config"))
  end

  def test_repository_bare_clone
    options = Ggit::CloneOptions.new(:bare => true)
    url = "https://github.com/ruby-gnome2/ggit.git"
    destination = Gio::File.path("#{@path}/ggit-clone-bare")
    Ggit::Repository.clone(url, destination, options)
    assert(File.exist?(@path + "/ggit-clone-bare/config"))
  end

  def test_repository_checkout_clone
    options = Ggit::CloneOptions.new(:checkout_branch => "master")
    url = "https://github.com/ruby-gnome2/ggit.git"
    destination = Gio::File.path("#{@path}/ggit-clone-checkout")
    Ggit::Repository.clone(url, destination, options)
    assert(File.exist?(@path + "/ggit-clone-checkout/.git/config"))
  end

  def cleanup
    FileUtils.rm_rf("#{@path}/non_bare_repo")
    FileUtils.rm_rf("#{@path}/bare_repo")
    FileUtils.rm_rf("#{@path}/ggit-clone")
    FileUtils.rm_rf("#{@path}/ggit-clone-bare")
    FileUtils.rm_rf("#{@path}/ggit-clone-checkout")
  end
end
