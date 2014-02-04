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
  
  notify{ 'Ensuring server dependencies':
    message => "Ensuring the availability of software required by a CollectionSpace server ...",
    withpath => false,
  }
  notify{ 'Ensuring Ant':
    message => "Ensuring the availability of Apache Ant ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring Augeas':
    message => "Ensuring the availability of Augeas libraries for Ruby ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring Curl':
    message => "Ensuring the availability of Curl ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring Ftp':
    message => "Ensuring the availability of an FTP client ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring Git':
    message => "Ensuring the availability of a Git client ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring ImageMagick':
    message => "Ensuring the availability of ImageMagick ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring Maven':
    message => "Ensuring the availability of Apache Maven ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
  notify{ 'Ensuring Wget':
    message => "Ensuring the availability of Wget ...",
    require => Notify [ 'Ensuring server dependencies' ],
  }
          
  case $os_family {
    Debian: {
      $exec_paths = $linux_exec_paths
      # At least under Ubuntu 13.10, it was necessary to first update the list of apt-get packages
      # in order to successfully install the 'imagemagick' package, below. Without doing so,
      # that install failed with '404 Not Found' errors attempting to access dependent packages in
      # http://archive.ubuntu.com/ubuntu/pool/main/c/cups/...
      exec { 'Update apt-get before dependencies update to reflect current packages' :
        command => 'apt-get -y update',
        path    => $exec_paths,
        before  => [
          Notify [ 'Ensuring Ant' ],
          Notify [ 'Ensuring Augeas' ],
          Notify [ 'Ensuring Curl' ],
          Notify [ 'Ensuring Ftp' ],
          Notify [ 'Ensuring Git' ],
          Notify [ 'Ensuring ImageMagick' ],
          Notify [ 'Ensuring Maven' ],
          Notify [ 'Ensuring Wget' ],
        ],
        require => Notify [ 'Ensuring server dependencies' ],
      }
      package { 'ant':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Ant' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      package { 'curl':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Curl' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      package { 'ftp':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Ftp' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      package { 'git':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Git' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      package { 'maven':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Maven' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      package { 'wget':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Wget' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      # Packages whose names differ between Debian- and RedHat-based distros:
      #
      # Equivalent to RedHat's 'ImageMagick', below.
      package { 'imagemagick':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring ImageMagick' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }
      # The following package (and its equivalent for RedHat-based distros) is required
      # by some Puppet modules (e.g. postgres) for editing config files.
      # Equivalent to RedHat's 'ruby-augeas', below.
      package { 'libaugeas-ruby':
        ensure  => latest,
        require => [
          Notify [ 'Ensuring Augeas' ],
          Exec [ 'Update apt-get before dependencies update to reflect current packages' ],
        ],
      }     
    }

    RedHat: {
      package { 'ant':
        ensure  => latest,
        require => Notify [ 'Ensuring Ant' ],
      }
      package { 'curl':
        ensure  => latest,
        require => Notify [ 'Ensuring Curl' ],
      }
      package { 'ftp':
        ensure  => latest,
        require => Notify [ 'Ensuring Ftp' ],
      }
      package { 'git':
        ensure  => latest,
        require => Notify [ 'Ensuring Git' ],
      }
      package { 'maven':
        ensure  => latest,
        require => Notify [ 'Ensuring Maven' ],
      }
      package { 'wget':
        ensure  => latest,
        require => Notify [ 'Ensuring Wget' ],
      }
      # Packages whose names differ between Debian- and RedHat-based distros:
      #
      # Equivalent to Debian's 'imagemagick', above.
      package { 'ImageMagick':
        ensure  => latest,
        require => Notify [ 'Ensuring ImageMagick' ],
      }
      # Equivalent to Debian's 'libaugeas-ruby', above.      
      package { 'ruby-augeas':
        ensure  => latest,
        require => Notify [ 'Ensuring Augeas' ],
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