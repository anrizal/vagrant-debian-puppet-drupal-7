#${name} is the $conf_files we defined
#vagrant specific
#puppet:///modules/my_module/file should match 
#%vagrant_root%/modules/my_module/files/file
define drush::conf_file($version = "5.9.0") {
  file { "/opt/drush-${version}/${name}":
    owner => root,
    group => root,
    mode => 0444,
    source => "puppet:///modules/drush/${name}",
  }
}