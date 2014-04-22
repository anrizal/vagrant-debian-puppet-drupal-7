class apache (
 # A list of modules to have enabled
  $modules = [
    'rewrite',
    'headers',
],$conf_files = [
    'apache2.conf',
  ]

) {

 # make sure apache2 is installed 
 package { 'apache2':
    ensure => installed,
 }
 
 # make sure apache2-mpm-prefork is running 
 package { 'apache2-mpm-prefork':
    ensure => installed,
    require => Package['apache2'],
  } 

 # make sure apache is running 
 service { apache2:
    enable => true,
    ensure => running,
    require => Package['apache2'],
  }

 # make sure the following module is installed
 apache::module { $modules:
  require => Package['apache2'],
 }

  # make sure apt-get has run
 Package {
   require => Exec['apt-get update']
 }

#change document root to vagrant/sites
  file { '/var/www':
     ensure => 'link',
     target => '/vagrant/sites',
     force => true,
  }

#custom apache settings
 apache::conf_file { $conf_files: }

}


