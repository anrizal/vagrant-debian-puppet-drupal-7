#${name} is the $conf_files we defined
#vagrant specific
#puppet:///modules/my_module/file should match 
#%vagrant_root%/modules/my_module/files/file
define xhprof::conf_file() {
  file { "/etc/php5/${name}":
    owner => root,
    group => root,
    mode => 0444,
    source => "puppet:///modules/xhprof/${name}",
    require => Package[$php::packages]
  }
}