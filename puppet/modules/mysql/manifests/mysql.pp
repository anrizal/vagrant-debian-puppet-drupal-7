class mysql (
  #variables for mysql configuration
  $packages = [
    'mysql-common',
    'mysql-server',
  ],
  $conf_files = [
    'char.cnf',
    'innodb.cnf',
  ],
  $password = 'root',
  $hostname = 'localhost',
  $local_only = true,
) {
  package { $packages:
    ensure => installed,
    # innodb settings
    require => File['/etc/mysql/conf.d/innodb.cnf']
  }

  service { mysql:
    enable => true,
    ensure => running,
    subscribe => Package['mysql-server']
  }

  exec { 'mysqladmin password':
    unless => "mysqladmin -uroot -p${password} status",
    path => ['/bin', '/usr/bin'],
    command => "mysqladmin -uroot password ${password}",
    require => Service['mysql'],
  }

  file { "/etc/mysql":
    ensure => directory
  }

  file { "/etc/mysql/conf.d":
    ensure => directory
  }

  #call new custom type
  conf_file { $conf_files:
  }

  if ! $local_only {
    file { '/etc/mysql/dbnode-my.cnf':
      owner  => root,
      group  => root,
      mode   => '0444',
      source => 'puppet:///modules/mysql/dbnode-my.cnf',
      path   => '/etc/mysql/my.cnf',
      notify => Service['mysql']
    }
  }
}