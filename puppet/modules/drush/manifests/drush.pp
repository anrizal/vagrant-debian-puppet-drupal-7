class drush (
  $version = "5.9.0",
  $owner = "vagrant",
  $group = "vagrant",
  ) {

  #this will download to /home/vagrant
  exec { 'download-drush':
    command => "wget https://github.com/drush-ops/drush/archive/${version}.tar.gz",
    path => '/usr/bin/',
    onlyif => "test -e /home/vagrant/${version}.tar.gz"
  }  

  exec { 'extract-drush':
    command => "tar -C /opt/ -xzf ${version}.tar.gz",
    path => '/bin',
    require => Exec ["download-drush"],
    onlyif => "test -d /opt/drush-${version}/",
  }

  file { "/opt/drush-${version}":
    ensure => 'directory',
    owner => $owner,
    group => $group,
    mode => 775,
    recurse => true,
    require => Exec["extract-drush"]
 }

  file { "/usr/sbin/drush":
    ensure => link,
    target => "/opt/drush-${version}/drush",
    require => File["/opt/drush-${version}"],
  }

 drush::conf_file { 'drush.ini':
    version => $version,
 }

}