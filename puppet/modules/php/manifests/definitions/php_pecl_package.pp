#${name} is the $conf_files we defined
define php::pecl_package() {
  exec { "pecl-install-${name}":
    command => "/usr/bin/pecl install $name",
    require => Package['php-pear', 'build-essential', 'php5-dev'],
    unless => "/usr/bin/pecl shell-test $name"
  }
}
