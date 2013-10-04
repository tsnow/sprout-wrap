my_dotfiles_path = "#{node['sprout']['home']}/my-dotfiles"
execute "clone my-dotfiles" do
  command "git clone git@github.com:tsnow/dotfiles.git my-dotfiles"
  user node['current_user']
  cwd "#{node['sprout']['home']}/"
  not_if { ::File.exists?(my_dotfiles_path) }
end

execute "install my-dotfiles" do
  command "./install.sh && ls -al ~/ | grep my-dotfiles > ./last_install.ls.log "
  user node["current_user"]
  cwd "#{node['sprout']['home']}/"
  only_if do
    ls_file = ::File.join(my_dotfiles_path,'last_install.ls.log');
    last_ls = ::File.exists?(ls_file) && ::File.read(ls_file)
    [last_ls, ""].include?(`ls -al ~/ | grep my-dotfiles`)
  end
end
