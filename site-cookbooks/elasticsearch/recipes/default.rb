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
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.9.deb
    dpkg -i elasticsearch-0.90.9.deb
    rm elasticsearch-0.90.9.deb
  EOF
end

service "elasticsearch" do
  action :start
end

