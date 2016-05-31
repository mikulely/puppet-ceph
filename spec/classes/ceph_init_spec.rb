require 'spec_helper'

describe 'ceph' do

  describe 'RedHat Family' do
    let :facts do
      {
        :osfamily => 'RedHat',
      }
    end

    describe "with default params and specified fsid" do
      let :params do
        {
          :fsid                => 'd5252e7d-75bc-4083-85ed-fe51fa83f62b',
          :mon_initial_members => 'host0',
          :mon_host            => '192.168.10.11',
          :cluster_network     => '10.0.0.0/24',
          :public_network      => '192.168.0.0/24',
          :debug_enable        => 'false',
        }
      end

      it { should contain_package('ceph') }

      it { should contain_ceph_config('global/fsid').with_value('d5252e7d-75bc-4083-85ed-fe51fa83f62b') }
      it { should contain_ceph_config('global/osd_pool_default_pg_num').with_value('2048') }
      it { should contain_ceph_config('global/osd_pool_default_pgp_num').with_value('2048') }
      it { should contain_ceph_config('global/osd_pool_default_size').with_value('2') }
      it { should contain_ceph_config('global/osd_pool_default_min_size').with_value('1') }
      it { should contain_ceph_config('global/osd_pool_default_crush_rule').with_value('2') }
      it { should contain_ceph_config('global/mon_osd_full_ratio').with_value('0.95') }
      it { should contain_ceph_config('global/mon_osd_nearfull_ratio').with_value('0.85') }
      it { should contain_ceph_config('global/mon_initial_members').with_value('host0') }
      it { should contain_ceph_config('global/mon_host').with_value('192.168.10.11') }
      it { should contain_ceph_config('global/cluster_network').with_value('10.0.0.0/24') }
      it { should contain_ceph_config('global/public_network').with_value('192.168.0.0/24') }
      it { should contain_ceph_config('global/auth_cluster_required').with_value('cephx') }
      it { should contain_ceph_config('global/auth_service_required').with_value('cephx') }
      it { should contain_ceph_config('global/auth_client_required').with_value('cephx') }
      it { should contain_ceph_config('global/auth_supported').with_value('cephx') }

      it { should contain_ceph_config('global/debug_lockdep').with_value('0/0') }
      it { should contain_ceph_config('global/debug_context').with_value('0/0') }
      it { should contain_ceph_config('global/debug_crush').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mds').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mds_balancer').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mds_locker').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mds_log').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mds_log_expire').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mds_migrator').with_value('0/0') }
      it { should contain_ceph_config('global/debug_buffer').with_value('0/0') }
      it { should contain_ceph_config('global/debug_timer').with_value('0/0') }
      it { should contain_ceph_config('global/debug_filer').with_value('0/0') }
      it { should contain_ceph_config('global/debug_objecter').with_value('0/0') }
      it { should contain_ceph_config('global/debug_rados').with_value('0/0') }
      it { should contain_ceph_config('global/debug_rbd').with_value('0/0') }
      it { should contain_ceph_config('global/debug_journaler').with_value('0/0') }
      it { should contain_ceph_config('global/debug_objectcacher').with_value('0/0') }
      it { should contain_ceph_config('global/debug_client').with_value('0/0') }
      it { should contain_ceph_config('global/debug_osd').with_value('0/0') }
      it { should contain_ceph_config('global/debug_optracker').with_value('0/0') }
      it { should contain_ceph_config('global/debug_objclass').with_value('0/0') }
      it { should contain_ceph_config('global/debug_filestore').with_value('0/0') }
      it { should contain_ceph_config('global/debug_journal').with_value('0/0') }
      it { should contain_ceph_config('global/debug_ms').with_value('0/0') }
      it { should contain_ceph_config('global/debug_mon').with_value('0/0') }
      it { should contain_ceph_config('global/debug_monc').with_value('0/0') }
      it { should contain_ceph_config('global/debug_paxos').with_value('0/0') }
      it { should contain_ceph_config('global/debug_tp').with_value('0/0') }
      it { should contain_ceph_config('global/debug_auth').with_value('0/0') }
      it { should contain_ceph_config('global/debug_finisher').with_value('0/0') }
      it { should contain_ceph_config('global/debug_heartbeatmap').with_value('0/0') }
      it { should contain_ceph_config('global/debug_perfcounter').with_value('0/0') }
      it { should contain_ceph_config('global/debug_rgw').with_value('0/0') }
      it { should contain_ceph_config('global/debug_hadoop').with_value('0/0') }
      it { should contain_ceph_config('global/debug_asok').with_value('0/0') }
      it { should contain_ceph_config('global/debug_throttle').with_value('0/0') }

      it { should contain_ceph_config('global/perf').with_value('true') }
      it { should contain_ceph_config('global/mutex_perf_counter').with_value('false') }

    end

    describe "with custom params and specified fsid" do
      let :params do
        {
          :fsid                        => 'd5252e7d-75bc-4083-85ed-fe51fa83f62b',
          :auth_enable                 => 'false',
          :osd_pool_default_pg_num     => '256',
          :osd_pool_default_pgp_num    => '256',
          :osd_pool_default_size       => '2',
          :osd_pool_default_min_size   => '1',
          :osd_pool_default_crush_rule => 'data',
          :mon_osd_full_ratio          => '0.80',
          :mon_osd_nearfull_ratio      => '0.70',
          :mon_initial_members         => 'mon.01',
          :mon_host                    => 'mon01.ceph, mon02.ceph',
          :cluster_network             => '10.0.1.0/24',
          :public_network              => '192.168.1.0/24',
          :debug_enable                => 'true',
          :perf                        => 'false',
          :mutex_perf_counter          => 'true',
        }
      end

      it { should contain_package('ceph') }

      it { should contain_ceph_config('global/fsid').with_value('d5252e7d-75bc-4083-85ed-fe51fa83f62b') }
      it { should contain_ceph_config('global/osd_pool_default_pg_num').with_value('256') }
      it { should contain_ceph_config('global/osd_pool_default_pgp_num').with_value('256') }
      it { should contain_ceph_config('global/osd_pool_default_size').with_value('2') }
      it { should contain_ceph_config('global/osd_pool_default_min_size').with_value('1') }
      it { should contain_ceph_config('global/osd_pool_default_crush_rule').with_value('0') }
      it { should contain_ceph_config('global/mon_osd_full_ratio').with_value('0.80') }
      it { should contain_ceph_config('global/mon_osd_nearfull_ratio').with_value('0.70') }
      it { should contain_ceph_config('global/mon_initial_members').with_value('mon.01') }
      it { should contain_ceph_config('global/mon_host').with_value('mon01.ceph, mon02.ceph') }
      it { should contain_ceph_config('global/cluster_network').with_value('10.0.1.0/24') }
      it { should contain_ceph_config('global/public_network').with_value('192.168.1.0/24') }
      it { should contain_ceph_config('global/auth_cluster_required').with_value('none') }
      it { should contain_ceph_config('global/auth_service_required').with_value('none') }
      it { should contain_ceph_config('global/auth_client_required').with_value('none') }
      it { should contain_ceph_config('global/auth_supported').with_value('none') }

      it { should_not contain_ceph_config('global/debug_lockdep').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_context').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_crush').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mds').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mds_balancer').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mds_locker').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mds_log').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mds_log_expire').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mds_migrator').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_buffer').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_timer').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_filer').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_objecter').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_rados').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_rbd').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_journaler').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_objectcacher').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_client').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_osd').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_optracker').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_objclass').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_filestore').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_journal').with_value('0') }
      it { should_not contain_ceph_config('global/debug_ms').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_mon').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_monc').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_paxos').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_tp').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_auth').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_finisher').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_heartbeatmap').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_perfcounter').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_rgw').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_hadoop').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_asok').with_value('0/0') }
      it { should_not contain_ceph_config('global/debug_throttle').with_value('0/0') }

      it { should contain_ceph_config('global/perf').with_value('false') }
      it { should contain_ceph_config('global/mutex_perf_counter').with_value('true') }
    end
  end
end
