# == Class: server_dependencies
#
# Manages prerequisites / dependencies for building a CollectionSpace server instance.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { server_dependencies:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#

include cspace_environment::execpaths
include cspace_environment::osfamily

class cspace_server_dependencies {
  
  $linux_exec_paths = $cspace_environment::execpaths::linux_default_exec_paths
  $os_family        = $cspace_environment::osfamily::os_family
  
  case $os_family {
    Debian: {
      $exec_paths = $linux_exec_paths
      exec { 'Update apt-get before dependencies update to reflect current packages' :
        command => 'apt-get -y update',
        path    => $exec_paths,
      }
      package { 'ant':
        ensure  => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      package { 'curl':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      package { 'ftp':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      package { 'git':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      package { 'maven':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      # 'wget' likely would have already been installed as part of the current bootstrap script; see:
      # https://github.com/cspace-puppet/cspace_puppet_bootstrap
      # This resource helps ensure its presence - and its latest available version,
      # as per platform-specific repositories - even if that bootstrap script
      # hadn't previously been run or if the 'wget' package was subsequently removed.
      package { 'wget':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      # Packages whose names differ between Debian- and RedHat-based distros:
      #
      # Equivalent to RedHat's 'ImageMagick', below.
      package { 'imagemagick':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }
      # The following package (and its equivalent for RedHat-based distros) is required
      # by some Puppet modules (e.g. postgres) for editing config files.
      # Equivalent to RedHat's 'ruby-augeas', below.
      package { 'libaugeas-ruby':
        ensure => latest,
        require => Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
      }     
    }

    RedHat: {
      package { 'ant':
        ensure  => latest,
      }
      package { 'curl':
        ensure => latest,
      }
      package { 'ftp':
        ensure => latest,
      }
      package { 'git':
        ensure => latest,
      }
      package { 'maven':
        ensure => latest,
      }
      package { 'wget':
        ensure => latest,
      }
      # Packages whose names differ between Debian- and RedHat-based distros:
      #
      # Equivalent to Debian's 'imagemagick', above.
      package { 'ImageMagick':
        ensure => latest,
      }
      # Equivalent to Debian's 'libaugeas-ruby', above.      
      package { 'ruby-augeas':
        ensure => latest,
      }
    }
    
    # OS X
    darwin: {
    }
    
    # Microsoft Windows
    windows: {
    }
  
    default: {
    }
    
  } # end case
  

  
}

