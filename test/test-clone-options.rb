class TestCloneOptions < Test::Unit::TestCase
  def test_new
    clone_options = Ggit::CloneOptions.new(:bare => true,
                                           :checkout_branch => "master")

    assert(clone_options.bare?)
    assert_equal("master", clone_options.checkout_branch)
  end
end
