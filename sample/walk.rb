# https://github.com/GNOME/libgit2-glib/blob/master/examples/walk.c

require "ggit"

USAGE = "Usage: walk.rb path_to_git_repository [N_REVISIONS]\n"
PATH = File.expand_path(File.dirname(__FILE__))

def check_directory(arg)
  if Dir.exists?("#{arg}/.git")
    arg
  elsif Dir.exists("#{PATH}/#{arg}/.git")
   "#{PATH}/#{arg}/.git"
  else
   STDERR.puts "bad directory"
   STDERR.puts USAGE
   exit 1
  end
end

def signature_to_string(signature)
  name = signature.name
  email = signature.email
  time = signature.time.format("%c")

  "#{name} <#{email}> #{time}"
end

n_revisions = 0
repo_path = nil

if ARGV.size == 1 || ARGV.size == 2
  n_revisions = ARGV[1].to_i || 10
  repo_path = ARGV[0]
else
  STDERR.puts USAGE
  exit 1
end

file = Gio::File.path(repo_path)

begin
  repo = Ggit::Repository.open(file)
  revwalker = Ggit::RevisionWalker.new(repo)
  revwalker.sort_mode = [:time, :topological]
  head = repo.head
  revwalker.push(head.target)
rescue => error
  STDERR.puts error.message
  exit 1
end


while oid = revwalker.next do
  commit = repo.lookup(oid, Ggit::Commit.gtype)

  author = signature_to_string(commit.author)
  committer = signature_to_string(commit.committer)

  subject = commit.subject
  message = commit.message

  puts "SHA: #{oid}"
  puts "Author:  #{author}"
  puts "Committer: #{committer}"
  puts "Subject: #{subject}"
  puts "Message: #{message}"
  puts "----------------------------------------"

  commit_parents = commit.parents
  if commit_parents.size > 0
    parent_commit = commit_parents.get(0)
    commit_tree = commit.tree
    parent_tree = parent_commit.tree

    diff = Ggit::Diff.new(repo, :old_tree => parent_tree,
                          :new_tree => commit_tree, :options => nil)

    diff.print( Ggit::DiffFormatType::PATCH ).each do |_delta, _hunk, line|
      puts "\t | #{line.text}"
      0
    end

  end

  n_revisions -= 1

  break unless n_revisions > 0
end
