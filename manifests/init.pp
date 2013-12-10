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
class cspace_server_dependencies {

  package { 'ant':
    ensure => latest,
  }

  package { 'maven':
    ensure => latest,
  }

  package { 'wget':
    ensure => latest,
  }

  package { 'curl':
    ensure => latest,
  }

  package { 'libaugeas-ruby':
    ensure => latest,
  }

  package { 'git':
    ensure => latest,
  }

  package { 'imagemagick':
    ensure => latest,
  }

  package { 'ftp':
    ensure => latest,
  }

}

