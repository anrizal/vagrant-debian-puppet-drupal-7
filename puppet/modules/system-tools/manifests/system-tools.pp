class system-tools (
  $packages = [
    'puppet-el',
    'htop',
    'git-core',
    'curl',
    'aptitude',
    'unzip',
    'nano',
    'make'
  ]
) {
  package { $packages:
    ensure => latest,
  }
  exec { 'apt-get update':
    command => "/usr/bin/apt-get update"
  }
  Package { require => Exec['apt-get update'] }
}
