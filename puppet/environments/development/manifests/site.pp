Package{allow_virtual => false,}

node  'util.example.com' {

  include openldap::server

}

#Openldap config
class { 'openldap::server': }
openldap::server::database { 'dc=util,dc=example.com':
  ensure => present,
}
 
