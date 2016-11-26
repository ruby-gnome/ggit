Gem::Specification.new do |s|
  s.name        = "ggit"
  s.version     = "0.0.1.pre"
  s.licenses    = ["GPL-2.0"]
  s.summary     = "libgit2-glib ruby loader."
  s.authors     = ["Ruby-GNOME2 Project Team"]
  s.files       = Dir.glob("lib/**/*") + ["COPYING.LIB", "README.md"]
  s.homepage    = "https://github.com/ruby-gnome2/ggit"
  s.add_runtime_dependency "gobject-introspection", "~> 3.0"
end
