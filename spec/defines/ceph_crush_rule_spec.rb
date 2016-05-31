require 'spec_helper'

describe 'ceph::crush_rule' do

  let :title do
    'openstack-leaf-osd'
  end

  describe 'with default parameters' do
    it { expect { should raise_error(Puppet::Error) } }
  end

  describe 'when overriding keyring_path' do
    let :params do
    {
      'root' => 'test',
      'leaf' => 'osd',
      'timeout' => '2',
    }
    end
    it { should contain_exec('create-ceph-crush-rule-openstack-leaf-osd').with(
      'command' => "timeout 2 ceph --name mon. --keyring /etc/ceph/ceph.mon.keyring osd crush rule create-simple openstack-leaf-osd test osd", 
      'unless'  => "timeout 2 ceph --name mon. --keyring /etc/ceph/ceph.mon.keyring osd crush rule list | grep -sqw 'openstack-leaf-osd'"
    )}
  end
end
