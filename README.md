# ruby-ggit

**This projet is currently held in abeyance due to
a lack of time. Feel free to contribute and extend it.**


Ruby loader for [libgit2-glib](https://git.gnome.org/browse/libgit2-glib) based on the ruby gobject-introspection gem from the
[ruby-GNOME2](https://github.com/ruby-gnome2/ruby-gnome2) project.

Documentation for libgit2-glib can be found [here](https://developer.gnome.org/libgit2-glib/) and
documentation for libgit2 can be found [here](https://libgit2.github.com/libgit2/#HEAD).

## Requirements

* Ruby/GObject-Introspection in [Ruby-GNOME2](http://ruby-gnome2.sourceforge.jp/)
* [GObject Introspection](http://live.gnome.org/GObjectIntrospection)
* [libgit2-glib](https://git.gnome.org/browse/libgit2-glib)

## Examples
From https://libgit2.github.com/docs/guides/101-samples/

### Using the library

```ruby
require "ggit"
```

### Repositories

#### Init

```ruby
# initialize with working directory (create and fill .git/)
dir = Gio::File.open(:path => "#{@path}/non_bare_repo/test")
Ggit::Repository.init_repository(dir, false)
# bare
dir = Gio::File.open(:path => "#{@path}/bare_repo/test/.git")
repo = Ggit::Repository.init_repository(dir, true)
```

### Clone

```ruby
url = "https://github.com/ruby-gnome2/ggit.git"
destination = Gio::File.open(:path => "#{@path}/ggit-clone")
Ggit::Repository.clone(url, destination)
```

## License

Copyright (c) 2016-2018 Ruby-GNOME2 Project Team

This program is free software. You can distribute/modify this program
under the terms of the GNU LESSER GENERAL PUBLIC LICENSE Version 2.1.

## Project Website
[ruby-Ggit](https://github.com/ruby-gnome2/ggit)
