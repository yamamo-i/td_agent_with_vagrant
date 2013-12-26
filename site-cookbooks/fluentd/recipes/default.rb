#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2011, Treasure Data, Inc.
#
# reference
# http://docs.fluentd.org/ja/articles/install-by-deb

cookbook_file "/tmp/td-agent.conf" do
  source "td-agent.conf"
  mode "664"
end


log "start: install_td-agent"

bash "install_td-agent" do
  code <<-EOF
    curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh
    curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-lucid.sh | sh
  EOF
end

log "finish: install_td-agent"

bash "elastic-search-plugin-install" do
  user "root"
  code <<-EOF
    /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch
    mv /etc/td-agnet/td-agent.conf /etc/td-agent/td-agent.conf.default
    mv /tmp/td-agent.conf /etc/td-agent/td-agent.conf
  EOF
end

execute "start_td-aget" do
  user "root"
  command "/etc/init.d/td-agent start"
  action :run
end

