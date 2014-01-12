#from osx_base
include_recipe "sprout-osx-apps::skype"
include_recipe "sprout-osx-apps::firefox"
include_recipe "pivotal_workstation::inputrc"
include_recipe "sprout-osx-apps::dropbox"
##include_recipe "sprout-osx-apps::chrome"
include_recipe "sprout-osx-settings::defaults_fast_key_repeat_rate"



# from osx_development
#include_recipe "pivotal_workstation::git_config_global_defaults"
include_recipe "pivotal_workstation::gitx"
#include_recipe "pivotal_workstation::github_for_mac"
include_recipe "sprout-osx-apps::iterm2"
include_recipe "sprout-osx-base::homebrew"
#include_recipe "pivotal_workstation::textmate"
#include_recipe "pivotal_workstation::textmate_preferences"
include_recipe "pivotal_workstation::unix_essentials"
include_recipe "sprout-osx-apps::vagrant"
include_recipe "pivotal_workstation::vim"
#include_recipe "pivotal_workstation::vim_config"
include_recipe "sprout-osx-apps::ctags_exuberant"
include_recipe "sprout-osx-apps::virtualbox"


# from ruby_development.
include_recipe "pivotal_workstation::rvm"
include_recipe "tm::mysql"
#include_recipe "pivotal_workstation::postgres"
include_recipe "pivotal_workstation::redis"
include_recipe "pivotal_workstation::memcached"

include_recipe "sprout-osx-apps::imagemagick"
#include_recipe "sprout-osx-apps::ffmpeg"
include_recipe "sprout-osx-apps::node_js"



# from pivotal-specifics
#include_recipe "pivotal_workstation::github_ssh_keys"
include_recipe "pivotal_workstation::keyboard_preferences"
include_recipe "pivotal_workstation::timemachine_preferences"


# tsnow specific
include_recipe "sprout-osx-apps::alfred"
#include_recipe 'sprout-osx-apps::charles_proxy' #file doesn't exist
#include_recipe 'sprout-osx-apps::evernote' #weird error

#include_recipe "sprout-osx-apps::skitch"
include_recipe "sprout-osx-apps::heroku_toolbelt"
#include_recipe "pivotal_workstation::pg_admin"

include_recipe "sprout-osx-settings::terminal_focus"
include_recipe "sprout-osx-settings::terminal_preferences"
include_recipe "sprout-osx-settings::set_finder_show_user_home_in_sidebar"
include_recipe "sprout-osx-settings::disable_front_row"
include_recipe "sprout-osx-settings::finder_display_full_path"



include_recipe "sprout-osx-apps::virtualbox"
include_recipe "sprout-osx-apps::vagrant"

include_recipe "sprout-osx-apps::jq"
include_recipe "sprout-osx-apps::go"
include_recipe "tm-osx-apps::emacs"
include_recipe "tm-osx-apps::postgres_app"
#include_recipe "tm-osx-apps::screenhero"




execute "always hibernate rather than sleep" do
  command "pmset -a hibernatemode 25"
end
