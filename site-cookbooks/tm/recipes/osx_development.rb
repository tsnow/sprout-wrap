#include_recipe "pivotal_workstation::git_config_global_defaults"
include_recipe "pivotal_workstation::gitx"
include_recipe "pivotal_workstation::github_for_mac"
include_recipe "sprout-osx-apps::iterm2"
include_recipe "sprout-osx-base::homebrew"
include_recipe "pivotal_workstation::sublime_text"
include_recipe "pivotal_workstation::textmate"
include_recipe "pivotal_workstation::textmate_preferences"
include_recipe "pivotal_workstation::unix_essentials"
include_recipe "sprout-osx-apps::vagrant"
include_recipe "pivotal_workstation::vim"
include_recipe "pivotal_workstation::vim_config"
include_recipe "sprout-osx-apps::ctags_exuberant"
include_recipe "sprout-osx-apps::virtualbox"

