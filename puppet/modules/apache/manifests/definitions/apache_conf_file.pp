#${name} is the $conf_files we defined
#vagrant specific
#puppet:///modules/my_module/file should match 
#%vagrant_root%/modules/my_module/files/file
define apache::conf_file() {
  file { "/etc/apache2/${name}":
    owner => root,
    group => root,
    mode => 0644,
    source => "puppet:///modules/apache/${name}",
    notify => Service[apache2]
  }
}