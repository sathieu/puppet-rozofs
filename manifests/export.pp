# = Define: rozofs::export
#
# Represents a RozoFS export
#
#
# == Parameters
#
# RozoFS specific parameters
#
# [*name*]
#   Export name.
#
# [*ensure*]
#   defined (also called present), unmounted, absent, mounted
#
# [*vid*]
#   Volume id
#
# [*password*]
#   Password
#
# [*squota*]
#   Soft quota
#
# [*hquota*]
#   Hard quota
#
# Note: volume expand or shrink is not supported
define rozofs::export (
  $vid,
  $ensure = 'mounted',
  $password = undef,
  $squota = undef,
  $hquota = undef,
  $options = 'posixlock,bsdlock,rozofsshaper=0',
) {
  if !$rozofs::exportd_ipaddress {
    fail('$rozofs::exportd_ipaddress is mandatory')
  }
  if !$rozofs::bool_is_manager_agent {
    fail('$rozofs::is_manager_agent should be true')
  }
  if !defined(Rozofs::Volume[$vid]) {
    fail("Rozofs::Volume[${vid}] is missing")
  }
  if !($ensure in ['defined', 'present', 'unmounted', 'absent', 'mounted']) {
    fail("Parameter \$ensure should be one of: defined (also called present), unmounted, absent, mounted")
  }
  if $password {
    $password_arg = "-p '${password}'"
  } else {
    $password_arg = ''
  }
  if $squota {
    $squota_arg = "-s '${squota}'"
  } else {
    $squota_arg = ''
  }
  if $hquota {
    $hquota_arg = "-a '${hquota}'"
  } else {
    $hquota_arg = ''
  }
  if $ensure == 'absent' {
      "rozo-export-remove-${name}":
        command => "echo 'You need to remove export ${name} manually' ; false",
        onlyif  => "rozo export -E '${rozofs::exportd_ipaddress}' list | grep '^\\s*-\\s*{root:' | grep '/${name}}\$'",
  } else {
    exec {
      "rozo-export-create-${name}":
        command => "rozo export -E '${rozofs::exportd_ipaddress}' create -n '${name}' ${password_arg} ${squota_arg} ${hquota_arg} ${vid}",
        unless  => "rozo export -E '${rozofs::exportd_ipaddress}' list | grep '^\\s*-\\s*{root:' | grep '/${name}}\$'",
    }
  }
  mount {
    "/mnt/rozofs@${rozofs::exportd_ipaddress}/${name}":
      ensure  => $ensure,
      device  => 'rozofsmount',
      fstype  => 'rozofs',
      options => "exporthost=${rozofs::exportd_ipaddress},exportpath=/srv/rozofs/exports/${name},_netdev,${options}";
  }
}
