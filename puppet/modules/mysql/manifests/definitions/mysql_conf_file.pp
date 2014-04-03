  #custom type
  #${name} is the $conf_files we defined
  #vagrant specific
  #puppet:///modules/my_module/file should match 
  #%vagrant_root%/modules/my_module/files/file
  define conf_file() {
    file { "/etc/mysql/conf.d/${name}":
      owner => root,
      group => root,
      mode => 0444,
      source => "puppet:///modules/mysql/conf.d/${name}",
      require => [File["/etc/mysql"],File["/etc/mysql/conf.d"]]
    }
  }