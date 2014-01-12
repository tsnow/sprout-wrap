unless File.exists?("/Applications/Postgres.app")

  remote_file "#{Chef::Config[:file_cache_path]}/PostgresApp-9-2-2-0.zip" do
    source "http://postgresapp.com/download"
    owner node['current_user']
    checksum "855f8a1e28b9986a4a184e1a94e620c5c303b41e"
  end

  execute "unzip PostgresApp" do
    command "unzip #{Chef::Config[:file_cache_path]}/PostgresApp-9-2-2-0.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute "copy Postgres.app to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Postgres.app #{Regexp.escape("/Applications/Postgres.app")}"
    user node['current_user']
    group "admin"
  end

  ruby_block "test to see if Postgres.app was installed" do
    block do
      raise "Postgres.app was not installed" unless File.exists?("/Applications/Postgres.app")
    end
  end

end
