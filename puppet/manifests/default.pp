class { 'system-tools': }
class { 'apache': }
class { 'mysql':
  local_only     => true
}
class { 'php': 
  development => true
}
class { 'postfix': }
class { 'drush':
  version => "5.9.0",
  owner => "vagrant",
  group => "vagrant", }