directory "/usr/local/bin" do
  owner node['current_user']
  recursive true
end

execute "your current user owns /usr/local" do
  command "chown -R #{node['current_user']} /usr/local"
  only_if { `find /usr/local -user "#{node['current_user']}" -maxdepth 0`.empty? }
end
