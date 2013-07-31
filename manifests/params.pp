# Class: rozofs::params
#
# This class defines default parameters used by the main module class rozofs
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to rozofs class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class rozofs::params {

  ### RozoFS specific parameters
  $is_manager_agent = true
  $manage_exportd = false
  $manage_storaged = true
  $manage_rozofsmount = true
  $use_pacemaker = false

  # Optional package
  $rozodebug = false

  ### Application related parameters

  $manager_package = $::operatingsystem ? {
    default => 'rozofs-manager-agent',
  }
  $exportd_package = $::operatingsystem ? {
    default => 'rozofs-exportd',
  }
  $storaged_package = $::operatingsystem ? {
    default => 'rozofs-storaged',
  }
  $rozofsmount_package = $::operatingsystem ? {
    default => 'rozofs-rozofsmount',
  }

  $manager_service = $::operatingsystem ? {
    default => 'rozofs-manager-agent',
  }
  $exportd_service = $::operatingsystem ? {
    default => 'rozofs-exportd',
  }
  $storaged_service = $::operatingsystem ? {
    default => 'rozofs-storaged',
  }
  $rozofsmount_service = $::operatingsystem ? {
    default => 'rozofs-rozofsmount',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'rozofs',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'rozofs',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/rozofs',
    default                   => '/etc/sysconfig/rozofs',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/rozofs.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/rozofs',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/rozofs',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/rozofs/rozofs.log',
  }

  $port = '42'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
