default['stack']['appuser']='studentapp'
default['stack']['apphomedir']="/home/#{node['stack']['appuser']}"
default['stack']['tomcat_url']="http://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz"
default['stack']['tarfile']="node['stack']['tomcat_url']".split('/').last
default['stack']['tarpath']="#{node['stack']['apphomedir']}/#{node['stack']['tarfile']}"
