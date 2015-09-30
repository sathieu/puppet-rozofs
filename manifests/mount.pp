# = Define: rozofs::mount
#
# Represents a RozoFS mount
#
#
# == Parameters
#
# RozoFS specific parameters
#
# [*name*]
#   Mount point.
#
# [*ensure*]
#   defined (also called present), unmounted, absent, mounted
#
# [*options*]
#   Mount options
#
# [*instance*]
#   Mount instance number
#
# [*owner*]
#   Mount point owner (set after mounting)
#
# [*group*]
#   Mount point group (set after mounting)
#
# [*mode*]
#   Mount point mode (set after mounting)
#
define rozofs::mount (
  $exportpath,
  $ensure = 'mounted',
  $options = 'rozofsshaper=0',
  $instance = undef,
  $owner = undef,
  $group = undef,
  $mode = undef,
) {
  # ===============================================================
  # Validation and variables
  # ===============================================================
  if !$rozofs::exportd_ipaddress {
    fail('$rozofs::exportd_ipaddress is mandatory')
  }
  if !($ensure in ['defined', 'present', 'unmounted', 'absent', 'mounted']) {
    fail('Parameter $ensure should be one of: defined (also called present), unmounted, absent, mounted')
  }
  $mountpoint_directory_ensure = $ensure ? {
    'absent'  => 'absent',
    default   => 'directory',
  }
  $mount_instance = $instance ? {
    undef    => '',
    /[0-9]+/ => ",instance=${instance}",
    default  => fail('Parameter $instance should be an integer or undef'),
  }
  $mount_options = $options ? {
    ''      => '',
    default => ",${options}",
  }
  # ===============================================================
  # Action
  # ===============================================================
  # Creating directory (default perms: user:group=root:root)
  exec { "mkdir --mode=0750 '${name}'":
    creates => $name,
  } ->
  # Mounting
  ::mount {
    $name:
      ensure  => $ensure,
      device  => 'rozofsmount',
      fstype  => 'rozofs',
      options => "exporthost=${::rozofs::exportd_ipaddress},exportpath=${exportpath},_netdev${mount_instance}${mount_options}",
      require => Package['rozofs-rozofsmount'],
  } ->
  # Fixing permissions
  file {
    $name:
      ensure => directory,
      owner  => $owner,
      group  => $group,
      mode   => $mode,
  }
}
