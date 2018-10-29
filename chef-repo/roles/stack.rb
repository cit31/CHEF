name "stack"
description "Role for Stack"
run_list "recipe[stack::app]", "recipe[stack::db]"
env_run_lists "prod" => ["recipe[stack::app]"], "dev" => ["recipe[stack::app]", "recipe[stack::db]"], "_default" => []
#default_attributes "apache2" => { "listen_ports" => [ "80", "443" ] }
#override_attributes "apache2" => { "max_children" => "50" }
