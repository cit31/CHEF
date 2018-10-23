package "Installing MariaDB server" do 
    package_name "mariadb-server"
    action :install
end

service "Starting MariaDB Service" do 
    service_name    "mariadb"
    action [ :enable, :start ]
end

cookbook_file 'Copying Student.SQL file to remote ndoe' do
    source 'student.sql'
    path    '/tmp/student.sql'
    action :create
end

execute 'Load Sql file' do
    command 'mysql < /tmp/student.sql'
end
