#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

cookbook_file "/tmp/KibanaConfig.rb" do
  source "KibanaConfig.rb"
  mode "664"
end

log "start: install_kibana"

bash "install_kibana" do
  user "root"
  code <<-EOF
    mkdir -p app
    cd ~/app
    apt-get -y install gcc ruby ruby-devel rubygems rdoc
    git clone --branch=kibana-ruby https://github.com/rashidkpc/Kibana.git
    cd Kibana/
    gem install bundler
    gem install eventmachine -v '1.0.3'
    bundle install
    mv /tmp/KibanaConfig.rb ~/app/Kibana
  EOF
end

log "finish: install_kibana"

execute "start-kibana" do
  user "root"
  command "ruby ~/app/Kibana/kibana.rb &"
  action :run
end

