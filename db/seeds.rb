require "rubygems"
require "factory_girl"
require "database_cleaner"

DatabaseCleaner.clean
FactoryGirl.reload

# prepare my-repo
FactoryGirl.define do
  factory "my-repo", :class => Repository do
    name "my-repo"
    url "git://github.com/user/my-repo"
    desc "This is my repository"
  end
end

my_repo = FactoryGirl.create("my-repo")

# prepare new-repo
FactoryGirl.define do
  factory "new-repo", :class => Repository do
    name "new-repo"
    url "git://github.com/user/new-repo"
    desc "This is my new repository"
  end
end

new_repo = FactoryGirl.create("new-repo")
new_repo.dependencies.push "my-repo"
new_repo.save
