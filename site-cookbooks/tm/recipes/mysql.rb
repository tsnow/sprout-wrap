#http://solutions.treypiepmeier.com/2010/02/28/installing-mysql-on-snow-leopard-using-homebrew/
require 'pathname'

PASSWORD = node["mysql_root_password"]

MYSQL_COMMAND = Object.new
def MYSQL_COMMAND.mysql
  case PASSWORD
  when "",nil then
    "mysql -uroot"
  else
    "mysql -uroot -p#{PASSWORD}"
  end
end
def MYSQL_COMMAND.set_password
  case PASSWORD
  when "", nil then
    %{mysql -uroot && echo "This only works on the first time"}
  else
    %{mysqladmin -uroot password "#{PASSWORD}"}
  end
end

# The next two directories will be owned by node['current_user']
DATA_DIR = "/usr/local/var/mysql"
PARENT_DATA_DIR = "/usr/local/var"

include_recipe "sprout-osx-base::homebrew"

[ "/Users/#{node['current_user']}/Library/LaunchAgents",
  PARENT_DATA_DIR,
  DATA_DIR ].each do |dir|
  directory dir do
    owner node['current_user']
    action :create
  end
end

# 2013-07-09 Install 5.6.10 because 5.6.12 doesn't work with mysql2 gem
# https://github.com/pivotal-sprout/sprout-wrap/issues/11
brew "https://raw.github.com/mxcl/homebrew/d28e5d5d6f1ec1cc383821750d2d6277030f06b9/Library/Formula/mysql.rb"

ruby_block "copy mysql plist to ~/Library/LaunchAgents" do
  block do
    active_mysql = Pathname.new("/usr/local/bin/mysql").realpath
    plist_location = (active_mysql + "../../"+"homebrew.mxcl.mysql.plist").to_s
    destination = "#{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
    system("cp #{plist_location} #{destination} && chown #{node['current_user']} #{destination}") || raise("Couldn't find the plist")
  end
end

ruby_block "mysql_install_db" do
  block do
    active_mysql = Pathname.new("/usr/local/bin/mysql").realpath
    basedir = (active_mysql + "../../").to_s
    data_dir = "/usr/local/var/mysql"
    system("mysql_install_db --verbose --user=#{node['current_user']} --basedir=#{basedir} --datadir=#{DATA_DIR} --tmpdir=/tmp && chown #{node['current_user']} #{data_dir}") || raise("Failed initializing mysqldb")
  end
  not_if { File.exists?("/usr/local/var/mysql/mysql/user.MYD")}
end

execute "load the mysql plist into the mac daemon startup thing" do
  command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
  user node['current_user']
  not_if { system("launchctl list com.mysql.mysqld") }
end

ruby_block "Checking that mysql is running" do
  block do
    Timeout::timeout(60) do
      until system("ls /tmp/mysql.sock")
        sleep 1
      end
    end
  end
end

execute "set the root password to the default" do
 command MYSQL_COMMAND.set_password
  not_if "#{MYSQL_COMMAND.mysql} -e 'show databases'"
end
=begin #not sure why this is breaking
I get:
Mixlib::ShellOut::ShellCommandFailed
------------------------------------
Expected process to exit with [0], but received '1'
---- Begin output of mysql_tzinfo_to_sql /usr/share/zoneinfo | sed
 's/Local time zone must be set--see zic manual page/XXT/' | mysql
 -uroot -ppassword ----
STDOUT:
STDERR: Warning: Using a password on the command line interface can be
 insecure.
Warning: Unable to load '/usr/share/zoneinfo/+VERSION' as time
 zone. Skipping it.
ERROR 1046 (3D000) at line 1: No database selected
---- End output of mysql_tzinfo_to_sql /usr/share/zoneinfo | sed
 's/Local time zone must be set--see zic manual page/XXT/' | mysql
 -uroot -ppassword ----


execute "insert time zone info" do
  command "mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/XXT/' | #{MYSQL_COMMAND.mysql}"
  not_if "#{MYSQL_COMMAND.mysql} -e 'select * from time_zone_name' | grep -q UTC"
end
=end

# Homebrew uses --sysconf=#{etc} to point to this file, and mysql ships
# with sql_mode=X,Y,Z, but our apps, especially the old apps, need
# sql_mode="". So fuck that file.
file "/usr/local/Cellar/mysql/*/my.cnf" do
  owner ENV['USER']
  group "wheel"
  mode "0644"
  action :create
  content ""
end
