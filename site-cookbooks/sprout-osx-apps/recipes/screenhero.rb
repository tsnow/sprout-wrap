dmg_package "Screenhero.app" do
  volumes_dir "Screenhero.app"
  source "http://screenhero.com/download.html?src=btn"
  checksum "c951c4dc05ff1091359358d710142cabef2c190be41f799244669f879cff7e80"
  action :install
  owner WS_USER
end


