#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

#package "openjdk-6"
#  action :install
#end

cookbook_file "/tmp/KibanaConfig.rb" do
  source "KibanaConfig.rb"
  mode "664"
end

bash "install_elasticsearch" do
  user "root"
  code <<-EOF
    cd ~/
    mkdir -p app
    cd app/
    curl -OL https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.6.tar.gz
    tar xzvf elasticsearch-0.20.6.tar.gz
    cd elasticsearch-0.20.6
  EOF
end

bash "install_kibana" do
  user "root"
  code <<-EOF
    cd ~/app
    apt-get -y install gcc ruby ruby-devel rubygems rdoc
    git clone --branch=kibana-ruby https://github.com/rashidkpc/Kibana.git
    cd Kibana/
    gem install bundler
    gem install eventmachine -v '1.0.3'
    bundle install
    mv /tmp/KibanaConfig.rb ~/
  EOF
end

execute "start-elasticsearch" do
  user "root"
  command "~/app/elasticsearch-0.20.6/bin/elasticsearch -f &"
  action :run
end

log "start: kibana up" do message "start: kibana up" end

execute "start-kibana" do
  user "root"
  command "ruby ~/app/Kibana/kibana.rb &"
  action :run
end

log "finish: kibana up" do message "finish: kibana up" end
