# = Class: rozofs
#
# This is the main rozofs class
#
#
# == Parameters
#
# RozoFS specific parameters
#
# [*exportd_ipaddress*]
#   IP address of the RozoFS exportd node (can be a virtual ip, managed by
#   pacemaker)
#
# [*is_manager_agent*]
#   Install rozofs-manager-agent
#
# [*manage_exportd*]
#   Install rozofs-exportd and enable it in manager
#
# [*manage_storaged*]
#   Install rozofs-storaged and enable it in manager
#
# [*manage_rozofsmount*]
#   Install rozofs-rozofsmount and enable it in manager
#
# [*use_pacemaker*]
#   Enable pacemaker in manager
#
# [*layout*]
#   RozoFS layout. See EXPORT.CONF(5) for more information.
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, rozofs class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $rozofs_myclass
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $rozofs_options
#
# [*service_autorestart*]
#   Automatically restarts the rozofs service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $rozofs_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $rozofs_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $rozofs_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $rozofs_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for rozofs checks
#   Can be defined also by the (top scope) variables $rozofs_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $rozofs_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $rozofs_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $rozofs_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $rozofs_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for rozofs port(s)
#   Can be defined also by the (top scope) variables $rozofs_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling rozofs. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $rozofs_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $rozofs_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $rozofs_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $rozofs_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in rozofs::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*manager_package*] [*exportd_package*] [*storaged_package*] [*rozofsmount_package*]
#   The name of the different rozofs packages
#
# [*manager_service*] [*exportd_service*] [*storaged_service*]
#   The names of rozofs services
#
# [*service_status*]
#   If the rozofs service init script supports status argument
#
# [*process*]
#   The name of rozofs process
#
# [*process_args*]
#   The name of rozofs arguments. Used by puppi and monitor.
#   Used only in case the rozofs process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user rozofs runs with. Used by puppi and monitor.
#
# [*config_file_init*]
#   Path of configuration file sourced by the rozofs-manager-agent init script
#
# [*config_file_init_template*]
#   Sets the path to the template to use as content for init configuration file
#   If defined, rozofs-manager-agent init config file has: content => content("$config_file_init_template")
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by pupp
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $rozofs_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $rozofs_protocol
#
#
# See README for usage patterns.
#
class rozofs (
  $exportd_ipaddress         = params_lookup( 'exportd_ipaddress' ),
  $is_manager_agent          = params_lookup( 'is_manager_agent' ),
  $manage_exportd            = params_lookup( 'manage_exportd' ),
  $manage_storaged           = params_lookup( 'manage_storaged' ),
  $manage_rozofsmount        = params_lookup( 'manage_rozofsmount' ),
  $use_pacemaker             = params_lookup( 'use_pacemaker' ),
  $layout                    = params_lookup( 'layout' ),
  $my_class                  = params_lookup( 'my_class' ),
  $service_autorestart       = params_lookup( 'service_autorestart' , 'global' ),
  $options                   = params_lookup( 'options' ),
  $version                   = params_lookup( 'version' ),
  $absent                    = params_lookup( 'absent' ),
  $disable                   = params_lookup( 'disable' ),
  $disableboot               = params_lookup( 'disableboot' ),
  $monitor                   = params_lookup( 'monitor' , 'global' ),
  $monitor_tool              = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target            = params_lookup( 'monitor_target' , 'global' ),
  $puppi                     = params_lookup( 'puppi' , 'global' ),
  $puppi_helper              = params_lookup( 'puppi_helper' , 'global' ),
  $firewall                  = params_lookup( 'firewall' , 'global' ),
  $firewall_tool             = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src              = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst              = params_lookup( 'firewall_dst' , 'global' ),
  $debug                     = params_lookup( 'debug' , 'global' ),
  $audit_only                = params_lookup( 'audit_only' , 'global' ),
  $noops                     = params_lookup( 'noops' ),
  $manager_package           = params_lookup( 'manager_package' ),
  $exportd_package           = params_lookup( 'exportd_package' ),
  $storaged_package          = params_lookup( 'storaged_package' ),
  $rozofsmount_package       = params_lookup( 'rozofsmount_package' ),
  $manager_service           = params_lookup( 'manager_service' ),
  $exportd_service           = params_lookup( 'exportd_service' ),
  $storaged_service          = params_lookup( 'storaged_service' ),
  $service_status            = params_lookup( 'service_status' ),
  $process                   = params_lookup( 'process' ),
  $process_args              = params_lookup( 'process_args' ),
  $process_user              = params_lookup( 'process_user' ),
  $config_file_init          = params_lookup( 'config_file_init' ),
  $config_file_init_template = params_lookup( 'config_file_init_template' ),
  $pid_file                  = params_lookup( 'pid_file' ),
  $data_dir                  = params_lookup( 'data_dir' ),
  $log_dir                   = params_lookup( 'log_dir' ),
  $log_file                  = params_lookup( 'log_file' ),
  $updatedb_file             = params_lookup( 'updatedb_file' ),
  $port                      = params_lookup( 'port' ),
  $protocol                  = params_lookup( 'protocol' )
  ) inherits rozofs::params {

  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_noops=any2bool($noops)

  $bool_is_manager_agent = any2bool($rozofs::is_manager_agent)
  $bool_manage_exportd = any2bool($rozofs::manage_exportd)
  $bool_manage_storaged = any2bool($rozofs::manage_storaged)
  $bool_manage_rozofsmount = any2bool($rozofs::manage_rozofsmount)
  $bool_use_pacemaker = any2bool($rozofs::use_pacemaker)

  ### Definition of some variables used in the module
  $manage_service_enable = $rozofs::bool_disableboot ? {
    true    => false,
    default => $rozofs::bool_disable ? {
      true    => false,
      default => $rozofs::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $rozofs::bool_disable ? {
    true    => 'stopped',
    default =>  $rozofs::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  # Don't start exportd service on boot when using pacemaker
  $manage_exportd_service_enable = $rozofs::bool_disableboot ? {
    true    => false,
    default => $rozofs::bool_disable ? {
      true    => false,
      default => $rozofs::bool_absent ? {
        true  => false,
        false => $rozofs::bool_use_pacemaker ? {
          true  => false,
          false => true,
        },
      },
    },
  }

  # Don't start exportd service when using pacemaker
  # as we don't know on which node exportd should be running
  $manage_exportd_service_ensure = $rozofs::bool_disable ? {
    true    => 'stopped',
    default =>  $rozofs::bool_absent ? {
      true    => 'stopped',
      default => $rozofs::bool_use_pacemaker ? {
          true  => undef,
          false => true,
      },
    },
  }

  $manage_service_autorestart = $rozofs::bool_service_autorestart ? {
    true    => Service['rozofs-manager-agent'],
    false   => undef,
  }

  $manage_file = $rozofs::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $rozofs::bool_absent == true
  or $rozofs::bool_disable == true
  or $rozofs::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $rozofs::bool_absent == true
  or $rozofs::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $rozofs::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  ### Managed resources
  package { $rozofs::manager_package:
    ensure  => bool2ensure($rozofs::is_manager_agent),
    noop    => $rozofs::bool_noops,
  }
  package { $rozofs::exportd_package:
    ensure  => bool2ensure($rozofs::manage_exportd),
    noop    => $rozofs::bool_noops,
  }
  package { $rozofs::storaged_package:
    ensure  => bool2ensure($rozofs::manage_storaged),
    noop    => $rozofs::bool_noops,
  }
  package { $rozofs::rozofsmount_package:
    ensure  => bool2ensure($rozofs::manage_rozofsmount),
    noop    => $rozofs::bool_noops,
  }

  if $rozofs::layout and $rozofs::exportd_ipaddress and $rozofs::bool_is_manager_agent {
    exec {
      'rozo-layout':
        command => "rozo layout -E '${rozofs::exportd_ipaddress}' set '${rozofs::layout}'",
        unless  => "rozo layout -E '${rozofs::exportd_ipaddress}' get | grep '^layout ${rozofs::layout}:'",
    }
  }

  if $bool_is_manager_agent {
    service { 'rozofs-manager-agent':
      ensure     => $rozofs::manage_service_ensure,
      name       => $rozofs::manager_service,
      enable     => $rozofs::manage_service_enable,
      hasstatus  => $rozofs::service_status,
      pattern    => $rozofs::process,
      require    => Package[$rozofs::manager_package],
      noop       => $rozofs::bool_noops,
    }
  }
  if $bool_manage_exportd {
    service { 'rozofs-exportd':
      ensure     => $rozofs::manage_exportd_service_ensure,
      name       => $rozofs::exportd_service,
      enable     => $rozofs::manage_exportd_service_enable,
      hasstatus  => $rozofs::service_status,
      pattern    => $rozofs::process,
      require    => Package[$rozofs::exportd_package],
      noop       => $rozofs::bool_noops,
    }
  }
  if $bool_manage_storaged {
    service { 'rozofs-storaged':
      ensure     => $rozofs::manage_service_ensure,
      name       => $rozofs::storaged_service,
      enable     => $rozofs::manage_service_enable,
      hasstatus  => $rozofs::service_status,
      pattern    => $rozofs::process,
      require    => Package[$rozofs::storaged_package],
      noop       => $rozofs::bool_noops,
    }
  }

  if $bool_is_manager_agent {
    file { 'rozofs-manager-agent.initconfig':
      ensure  => $rozofs::manage_file,
      path    => $rozofs::config_file_init,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Package[$rozofs::manager_package],
      notify  => $rozofs::manage_service_autorestart,
      content => template($config_file_init_template),
      audit   => $rozofs::manage_audit,
      noop    => $rozofs::bool_noops,
    }
  }

  if $bool_manage_rozofsmount and $rozofs::updatedb_file {
    # Don't scan RozoFS mountpoints (potentially huge)
    exec {
      'updatedb-prune-rozofs':
        command => "sed -i 's/PRUNEFS=\"\\(.*\\)\"/PRUNEFS=\"\\1 fuse.rozofs\"/' '${rozofs::updatedb_file}'",
        unless  => "grep -q fuse.rozofs '${rozofs::updatedb_file}'";
    }
  }

  ### Include custom class if $my_class is set
  if $rozofs::my_class {
    include $rozofs::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $rozofs::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'rozofs':
      ensure    => $rozofs::manage_file,
      variables => $classvars,
      helper    => $rozofs::puppi_helper,
      noop      => $rozofs::bool_noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $rozofs::bool_monitor == true {
    if $rozofs::port != '' {
      monitor::port { "rozofs_${rozofs::protocol}_${rozofs::port}":
        protocol => $rozofs::protocol,
        port     => $rozofs::port,
        target   => $rozofs::monitor_target,
        tool     => $rozofs::monitor_tool,
        enable   => $rozofs::manage_monitor,
        noop     => $rozofs::bool_noops,
      }
    }
    if $rozofs::service != '' {
      monitor::process { 'rozofs_process':
        process  => $rozofs::process,
        service  => $rozofs::service,
        pidfile  => $rozofs::pid_file,
        user     => $rozofs::process_user,
        argument => $rozofs::process_args,
        tool     => $rozofs::monitor_tool,
        enable   => $rozofs::manage_monitor,
        noop     => $rozofs::bool_noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $rozofs::bool_firewall == true and $rozofs::port != '' {
    firewall { "rozofs_${rozofs::protocol}_${rozofs::port}":
      source      => $rozofs::firewall_src,
      destination => $rozofs::firewall_dst,
      protocol    => $rozofs::protocol,
      port        => $rozofs::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $rozofs::firewall_tool,
      enable      => $rozofs::manage_firewall,
      noop        => $rozofs::bool_noops,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $rozofs::bool_debug == true {
    file { 'debug_rozofs':
      ensure  => $rozofs::manage_file,
      path    => "${settings::vardir}/debug-rozofs",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $rozofs::bool_noops,
    }
  }

}
