# Ensures package dependencies for openvox-server or openvoxdb.
#
# This class can be used for cases where openvox-server or openvoxdb
# packages are downloaded and installed directly, bypassing dependency
# handling by package managers like apt or dnf.
class kvm_automation_tooling::server::package_prerequisites () {
  notify { 'osfacts':
    message => "${facts['os']['family']}-${facts['os']['release']['major']}",
  }
  case $facts['os']['family'] {
    'RedHat': {
      $packages = [
        'net-tools',
        'procps-ng',
        'which',
      ]
    }
    'Debian': {
      $packages = [
        'net-tools',
        'procps',
      ]
    }
    default: {
      fail("Unsupported os: ${facts['os']}")
    }
  }
  package { $packages:
    ensure => present,
  }
}
