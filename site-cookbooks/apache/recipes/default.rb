#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

apt_package "apache2" do
  action :install
end

service "apache2" do
  action :start
end

bash "permission_controll" do
  user "root"
  code <<-EOF
    chmod 644 /var/log/apache2/access.log
    chmod 755 /var/log/apache2
  EOF

end

