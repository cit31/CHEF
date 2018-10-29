name 'prod'
description 'The production environment'
#cookbook_versions  'couchdb' => '= 11.0.0'
default_attributes 'stack' => { 'DBIP' => "stu-prd-db" }
