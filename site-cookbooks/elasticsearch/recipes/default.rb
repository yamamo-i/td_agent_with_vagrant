#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

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

execute "start-elasticsearch" do
  user "root"
  command "~/app/elasticsearch-0.20.6/bin/elasticsearch -f &"
  action :run
end

