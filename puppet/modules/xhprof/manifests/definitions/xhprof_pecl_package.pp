#${name} is the $conf_files we defined
define xhprof::pecl_package() {
  exec { "pecl-install-${name}":
    command => "/usr/bin/pecl install $name",
    require => Package['php-pear', 'build-essential', 'php5-dev'],
  }
}
