# = Define: rozofs::volume
#
# Represents a RozoFS volume
#
#
# == Parameters
#
# RozoFS specific parameters
#
# [*name*]
#   Volume id.
#
# [*nodes*]
#   Array of nodes
#
# Note: volume expand or shrink is not supported
define rozofs::volume (
  $nodes
) {
  if !$rozofs::exportd_ipaddress {
    fail('$rozofs::exportd_ipaddress is mandatory')
  }
  if !$rozofs::bool_is_manager_agent {
    fail('$rozofs::is_manager_agent should be true')
  }
  if !$rozofs::bool_is_manager_agent {
    fail('rozofs::volume resource name should be >=1')
  }
  exec {
    "rozo-expand-vid-${name}":
      command => inline_template('rozo expand -E "<%= scope.lookupvar("rozofs::exportd_ipaddress") %>" --vid "<%= @name %>" <%= @nodes.join("\n") %>'),
      unless  => "test `rozo  config -E '${rozofs::exportd_ipaddress}' --roles exportd | grep '^\\s\\+VOLUME:' | sed 's/^\\s\\+VOLUME:\\s*//'` = '${name}'",
  }
}
