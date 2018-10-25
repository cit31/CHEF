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

execute 'Extract Tomcat tar file' do
    command     "tar xzvf #{node['stack']['tarpath']}"
    cwd         "#{node['stack']['apphomedir']}"
    user        "#{node['stack']['appuser']}"
    group       "#{node['stack']['appuser']}"
    #not_if      { File.exists?("/file/contained/in/tar/here") }
end

Dir["#{node['stack']['tomcatdir']}/webapps/*"].each do |file_name|
    if File.directory?(file_name)
        directory "Removing Directory #{file_name}" do
            path        "#{file_name}"  
            recursive   true  
            action      :delete
        end
    elsif File.file?(file_name)
        file "Removing Files #{file_name}" do
            path        "#{file_name}"  
            action      :delete
        end
    end
end

remote_file 'Downloading JDBC Jar file' do
    source  "#{node['stack']['jdbc_url']}"
    path    "#{node['stack']['tomcatdir']}/lib/#{node['stack']['jdbc_file']}"
    owner   "#{node['stack']['appuser']}"
    group   "#{node['stack']['appuser']}"
    action  :create
end

template "Update context.xml with JDBC Connection" do 
    path    "#{node['stack']['tomcatdir']}/conf/context.xml"
    source  "context.xml.erb"
    owner   "#{node['stack']['appuser']}"
    group   "#{node['stack']['appuser']}"
    action  :create
end

template "Update tomcat init script" do 
    path    "/etc/init.d/tomcat"
    source  "tomcat-init.erb"
    action  :create
end

execute 'Extract Tomcat tar file' do
    command     "systemctl daemon-reload"
end

service "Start tomcat" do 
    service_name    "tomcat"
    action          [:start, :enable]
end