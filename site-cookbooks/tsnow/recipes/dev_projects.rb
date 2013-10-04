# Recipe to init git repositories into the users ~/dev directory
#
# The Github organization of the team should be defined in the
# node_attributes section of your `soloistrc` file. eg:
#
# node_attributes:
#   dev_projects:
#      directory: dev
#      github_organization: ridecharge

include_recipe "pivotal_workstation::workspace_directory"

def gh_env
  gh_user = ENV['GITHUB_USER']
  gh_pass = ENV['GITHUB_PASS']
  {:basic_auth => "#{gh_user}:#{gh_pass}", :user => gh_user} if gh_user && gh_pass
end
def gh_gitconfig
  gh_token = `git config --global github.token`.chomp
  gh_user = `git config --global github.user`.chomp
  {:oauth_token => gh_token, :user => gh_user} if !gh_token.empty? && !gh_user.empty?
end


github = ::Github.new (gh_gitconfig || gh_env)

repos = github.repos.all({
                           :org => node['dev_projects']['github_organization'], 
                           :auto_pagination => true
                         })
repos.each do |repo|
  repo_name = repo.name
  repo_address = repo.clone_url
  
  # Allow the user to override the working directory
  repo_dir ||= node['dev_projects']['directory']

  checkout_dir = ::File.join(node['sprout']['home'],repo_dir,repo_name)

  directory checkout_dir do
    owner node['current_user']
    action :create
  end


  execute "init #{repo_name}" do
    command "git init"
    user node['current_user']
    cwd checkout_dir
    not_if { ::File.exists?(::File.join(checkout_dir,'.git')) }
  end

  [
   "git remote add origin #{repo_address}",
   "git branch --set-upstream master origin/master",
  ].each do |git_cmd|
    execute "#{repo_name} - #{git_cmd}" do
      command git_cmd
      cwd "#{node['sprout']['home']}/#{repo_dir}/#{repo_name}"
      user node['current_user']
      only_if { `git remote`.empty? }
    end
  end
end

