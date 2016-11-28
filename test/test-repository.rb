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

  def cleanup
    FileUtils.rm_rf("#{@path}/non_bare_repo")
    FileUtils.rm_rf("#{@path}/bare_repo")
  end
end
