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

include cspace_environment::osfamily

class cspace_server_dependencies {
  
  $os_family        = $cspace_environment::osfamily::os_family
  
  case $os_family {
  
    # Packages whose names are identical between the two major Linux OS families
    RedHat, Debian: {
      package { 'ant':
        ensure => latest,
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
  
  # Packages whose names differ between the two major Linux OS families
  case $os_family {
    RedHat: {
      package { 'ImageMagick':
        ensure => latest,
      }
      # The following package (and its equivalent for Debian) is required
      # by some Puppet modules (e.g. postgres) for editing config files.
      package { 'ruby-augeas':
        ensure => latest,
      }
    }
    Debian: {
      package { 'imagemagick':
        ensure => latest,
      }
      # Equivalent to RedHat's 'ruby-augeas', above.
      package { 'libaugeas-ruby':
        ensure => latest,
      }
    }
    default: {
    }
  } # end case
  
}

