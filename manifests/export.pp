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
  $password = undef,
  $squota = undef,
  $hquota = undef,
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
  exec {
    "rozo-export-create-${name}":
      command => "rozo export -E '${rozofs::exportd_ipaddress}' create -n '${name}' ${password_arg} ${squota_arg} ${hquota_arg}",
      unless  => "rozo export -E '${rozofs::exportd_ipaddress}' list | grep '^\\s*-\\s*{root:' | grep '/${name}}\$'",
  }
}
