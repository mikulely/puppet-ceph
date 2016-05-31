require 'spec_helper'

describe 'ceph::auth_key' do

  let :title do
    'client.dummy'
  end

  describe 'with default parameters' do
    it { expect { should raise_error(Puppet::Error) } }
  end

  describe 'when overriding keyring_path' do
    let :params do
    {
      'keyring_path' => '/dummy/path/for/keyring',
      'timeout' => '2',
    }
    end
    it { should contain_exec('ceph-inject-key-client.dummy').with(
      'command' => "timeout 2 ceph --name mon. --keyring /etc/ceph/ceph.mon.keyring auth add 'client.dummy' --in-file /dummy/path/for/keyring", 
      'onlyif'  => "timeout 2 ceph --name mon. --keyring /etc/ceph/ceph.mon.keyring -s",
      'unless'  => "timeout 2 ceph --name mon. --keyring /etc/ceph/ceph.mon.keyring auth list | grep -sqw 'client.dummy'"
    )}
  end
end
