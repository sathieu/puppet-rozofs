# Puppet module: rozofs

This is a Puppet module for rozofs based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Mathieu Parent, based on Example42 modules from Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-rozofs

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Complete example

        class {
          'rozofs':
            exportd_ipaddress => '10.1.1.1', # IP address of node1
            manage_exportd    => $::hostname in ['node1'],
            use_pacemaker     => false,
            layout            => 1,
        }
        rozofs::volume {
          '1':
            nodes => [
              '10.1.1.1',
              '10.1.1.2',
              '10.1.1.3',
              '10.1.1.4',
              '10.1.1.5',
              '10.1.1.6',
              '10.1.1.7',
              '10.1.1.8',
            ];
        }



## USAGE - Basic management

* Install rozofs with default settings

        class { 'rozofs': }

* Install a specific version of rozofs package

        class { 'rozofs':
          version => '1.0.1',
        }

* Disable rozofs service.

        class { 'rozofs':
          disable => true
        }

* Remove rozofs package

        class { 'rozofs':
          absent => true
        }

* Enable auditing without without making changes on existing rozofs configuration *files*

        class { 'rozofs':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Automatically include a custom subclass

        class { 'rozofs':
          my_class => 'example42::my_rozofs',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'rozofs':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'rozofs':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'rozofs':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'rozofs':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-rozofs.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-rozofs]
