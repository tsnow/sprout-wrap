brew "emacs --cocoa"

execute "brew linkapps emacs" do
  user node['current_user']
  command "brew linkapps emacs"
  not_if { ::File.exists?("/Applications/Emacs.app")}
end
