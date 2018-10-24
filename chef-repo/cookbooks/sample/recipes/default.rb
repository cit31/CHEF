#
# Cookbook:: sample
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

puts "Hello World"

#package 'httpd'

user  'user add ' do 
  comment 'sample'
  shell       '/bin/bash'
  username    'test'
  home	      '/home/test'
  manage_home true
end

log 'message' do
  message "#{node['sample']['curl']}"
  level :fatal
end
