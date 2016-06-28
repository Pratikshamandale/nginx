#
# Cookbook Name:: ngnix_naxsi_direct
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute



execute 'apt-get update' do
  command "sudo apt-get update"
  action :run
end


#install the 'Development tools' package group
%w[build-essential libpcre3 libpcre3-dev openssl libssl-dev unzip].each do |pkg|
  package pkg do
    action :install
  end
end

#install nginx-naxsi
package 'nginx' do
  action :install
end

#create nginx cache directory
directory node['nginx']['nginx_cache_dir'] do
  action :create
  recursive true
end


cookbook_file "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  owner "root"
  group "root"
  mode  "0644"
  action :create
end



#create ssl directory
directory node['nginx-naxsi']['nginx_ssl'] do
  action :create
  recursive true
end


#create and Copy ssl certificate file
cookbook_file "/etc/nginx/ssl/nginx.crt" do
  source "nginx.crt"
  owner "root"
  group "root"
  mode  "0755"
  action :create
end


#create and Copy ssl key file
cookbook_file "/etc/nginx/ssl/nginx.key" do
  source "nginx.key"
  owner "root"
  group "root"
  mode  "0755"
  action :create
end

#create and Copy ssl key file
cookbook_file "/usr/share/nginx/html/index.html" do
  source "index.html"
  owner "root"
  group "root"
  mode  "0755"
  action :create
end





service 'nginx' do
  action:restart
end
