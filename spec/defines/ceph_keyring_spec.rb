require 'spec_helper'

describe 'ceph::keyring' do

  let :title do
    'client.dummy'
  end

  describe 'with default parameters' do
    it { expect { should raise_error(Puppet::Error) } }
  end

  describe 'when setting secret' do
    let :params do
      { :secret => 'shhh_dont_tell_anyone' }
    end
    it { should contain_exec('ceph-keyring-client.dummy').with(
      'command' => "ceph-authtool /etc/ceph/ceph.client.dummy.keyring --create-keyring --name='client.dummy' --add-key='shhh_dont_tell_anyone' ",
      'creates' => '/etc/ceph/ceph.client.dummy.keyring'
    )}
  end

  describe 'when overriding keyring_path' do
    let :params do
    {
      'secret' => 'shhh_dont_tell_anyone',
      'keyring_path' => '/dummy/path/for/keyring',
    }
    end
    it { should contain_exec('ceph-keyring-client.dummy').with(
      'command' => "ceph-authtool /dummy/path/for/keyring --create-keyring --name='client.dummy' --add-key='shhh_dont_tell_anyone' ",
      'creates' => '/dummy/path/for/keyring'
    )}
  end

  describe 'when setting caps' do
    let :params do
    {
      'secret' => 'shhh_dont_tell_anyone',
      'cap_mon' => 'x',
      'cap_osd' => 'y',
      'cap_mds' => 'z',
    }
    end
    it { should contain_exec('ceph-keyring-client.dummy').with(
      'command' => "ceph-authtool /etc/ceph/ceph.client.dummy.keyring --create-keyring --name='client.dummy' --add-key='shhh_dont_tell_anyone' --cap mon 'x' --cap osd 'y' --cap mds 'z' ",
      'creates' => '/etc/ceph/ceph.client.dummy.keyring'
    )}
  end
end
