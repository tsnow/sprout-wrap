dev_dotfiles_path = "#{node['sprout']['home']}/dev-dotfiles"



directory dev_dotfiles_path do
  owner node['current_user']
  action :create
end

directory ::File.join(dev_dotfiles_path, 'private') do
  owner node['current_user']
  action :create
end


execute "clone dev-dotfiles-private" do
  command 'git clone -b master /Volumes/NO\ NAME/tsnow-dev-dotfiles-private.bundle private'
  user node['current_user']
  cwd dev_dotfiles_path
  not_if { ::File.exists?(::File.join(dev_dotfiles_path,'private/.git'))}
end


execute "clone dev-dotfiles" do
  command 'git clone -b master /Volumes/NO\ NAME/tsnow-dev-dotfiles.bundle dev-dotfiles'
  user node['current_user']
  cwd "#{node['sprout']['home']}/"
  not_if { ::File.exists?(::File.join(dev_dotfiles_path,'.git'))}

end
=begin
execute "install dev-dotfiles" do
  command "./install.sh && ls -al ~/ | grep dev-dotfiles > ./last_install.ls.log "
  user node["current_user"]
  cwd dev_dotfiles_path
  only_if do
    ls_file = ::File.join(dev_dotfiles_path,'last_install.ls.log');
    last_ls = ::File.exists?(ls_file) && ::File.read(ls_file)
    [last_ls, ""].include?(`ls -al ~/ | grep dev-dotfiles` )
  end
end
=end
