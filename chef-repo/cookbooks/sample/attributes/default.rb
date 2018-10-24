default['sample']['URL']='google.com'
default['sample']['curl']="http://#{node['sample']['URL']}"
default['sample']['tomcat_url']="http://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz"
default['sample']['tarfile']="#{node['sample']['tomcat_url']}"
