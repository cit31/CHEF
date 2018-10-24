package "Installing Java" do 
    package_name    "java"
    action          :install 
end

ruby_block 'Change login defs to create home directory' do
    block do
        text = File.read("/etc/login.defs").gsub("CREATE_HOME\tyes","CREATE_HOME\tno")
        File.open("/etc/login.defs", "w").write(text)
    end
    action :run
end

group 'Adding App group' do
    gid                   2000
    group_name            "#{node['stack']['appuser']}"
    action                :create
  end

user 'Adding StudentApp User' do
    comment     'Student Application User'
    gid         2000
    shell       '/bin/bash'
    username    "#{node['stack']['appuser']}"
    home        "#{node['stack']['apphomedir']}"
    manage_home true
end 

ruby_block 'Change login defs to default' do
    block do
        text = File.read("/etc/login.defs").gsub("CREATE_HOME\tno","CREATE_HOME\tyes")
        File.open("/etc/login.defs", "w").write(text)
    end
    action :run
end

remote_file 'Downloading Apache Tomcat' do
    source  "#{node['stack']['tomcat_url']}"
    path    "#{node['stack']['tarpath']}"
    owner   "#{node['stack']['appuser']}"
    group   "#{node['stack']['appuser']}"
    action  :create
end