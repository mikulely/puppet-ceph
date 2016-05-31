Use Cases
=========

I want to try this module, heard of ceph, want to see it in action
------------------------------------------------------------------

_Notice : Please note that your hostname cannot be localhost._

I want to run it on my own laptop, all in one. The **ceph** class will create configuration file with no authentication enabled, on my **test0.way**. The **ceph::mon** resource configures and runs a monitor to which two **ceph::osd** daemon will connect to provide disk storage, using disk in **/dev/sd\*** on the laptop.

    node 'test0.way' {

      class { 'ceph':
        osd_crush_chooseleaf_type => 'osd',
        auth_enable               => false,
        debug_enable              => true,
      }

      ceph::mon { $::hostname: }
      ceph::osd { '/dev/sdc1': }
      ceph::osd { '/dev/sdc2': }

      Ceph::Mon<| |> -> Ceph::Osd<| |>

    }

I want to operate a production cluster
---------------------------------------

I need three node role, monitor/storage/client.

    $journal_size = 10240

    node 'common' {
      class { 'ceph':
        mon_host                  => '172.16.94.131',  # all monitors' ip address
        mon_initial_members       => 'test0.way',      # all monitors' domain name
        osd_crush_chooseleaf_type => 'osd',            # if you have only one storage node, you need set it 'osd'
        cluster_network           => '10.0.1.0/24', # it is used for osd sync data
        public_network            => '10.0.2.0/24', # it is used for client access osd
        release                   => 'dumpling',
        auth_enable               => true,
        debug_enable              => false,            # disable debug can improve performance
      }

      ceph::keyring { 'client.openstack':              # it is necessarily for openstack client
        cap_mon       => 'allow *',
        cap_osd       => 'allow *',
      }
    }

    node 'monitor' inherits 'common' {
    }

    node 'storage' inherits 'common' {
    }

    node 'client' inherits 'common' {
    }

    node 'test0.way' inherits 'monitor' {
      ceph::mon { 'test0.way':
        mon_addr => '172.16.94.131',                   # it is necessarily for monitor
      }

      ceph::auth_key { 'client.admin': }               # we must inject client.admin key into ceph cluster
      ceph::auth_key { 'client.openstack': }           # we must inject client.openstack key into ceph cluster

      ceph::pool { 'data':
        ensure => false,
      }
      ceph::pool { 'metadata':
        ensure => false,
      }
      ceph::pool { 'rbd':
        ensure => false,
      }

      ceph::crush_rule { 'openstack-leaf-osd':         # we need some specail crush rule, it is useful
        leaf => 'osd',
      }
      ceph::crush_rule { 'openstack-leaf-host':        # we need some specail crush rule, it is useful
        leaf => 'host',
      }

    }

    node 'test1.way','test2.way' inherits 'storage' {
      ceph::osd { '/dev/sdc1':                         # this disk is used by osd filestore
        osd_journal_size => $journal_size,
        osd_journal      => '/dev/sdc2',               # this disk is used by osd journal
      }

      ceph::osd { '/dev/sdd1':
        osd_journal_size => $journal_size,
        osd_journal      => '/dev/sdd2',
      }
    }

    node 'test3.way' inherits 'client' {
    }

I want to use disk wwn number for deploy
----------------------------------------

You can find disk wwn number in **/dev/disk/by-id/**.

    node 'test0.way' {

      class { 'ceph':
        osd_crush_chooseleaf_type => 'osd',
        auth_enable               => false,
        debug_enable              => true,
      }

      ceph::mon { $::hostname: }
      ceph::osd { 'wwn-0x50025388a003b859': }
      ceph::osd { 'wwn-0x50015178f3629e29': }

      ceph::osd { 'wwn-0x50015178f3629e29-part1':
        osd_journal => '0x50015178f3629e29-part2',
      }
      ceph::osd { 'wwn-0x50015178f3629888-part1':
        osd_journal => '0x50015178f3629888-part2',
      }

      Ceph::Mon<| |> -> Ceph::Osd<| |>

    }
