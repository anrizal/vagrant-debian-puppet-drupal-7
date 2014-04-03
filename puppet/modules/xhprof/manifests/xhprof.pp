class xhprof (  $pecl_packages = [
    'xhprof-beta',
  ],
  $conf_files = [
    'conf.d/xhprof.ini',
  ],) {


 xhprof::pecl_package { $pecl_packages: }

 xhprof::conf_file { $conf_files:
    require => Package['php5']
 }

Package { require => Exec['apt-get update']} 

}