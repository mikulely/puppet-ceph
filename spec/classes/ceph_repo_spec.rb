require 'spec_helper'

describe 'ceph::repo' do

  describe 'RHEL6' do

    let :facts do
    {
      :osfamily         => 'RedHat',
    }
    end

    describe "with default params" do

      it { should contain_yumrepo('ext-epel-6.8').with(
        :descr      => 'External EPEL 6.8',
        :name       => 'ext-epel-6.8',
        :gpgcheck   => '0',
        :mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch'
      ) }

      it { should contain_yumrepo('ext-ceph').with(
        :descr      => 'External Ceph dumpling',
        :name       => 'ext-ceph-dumpling',
        :baseurl    => 'http://ceph.com/rpm-dumpling/el6/$basearch',
        :gpgcheck   => '1',
        :gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
     ) }

      it { should contain_yumrepo('ext-ceph-noarch').with(
        :descr      => 'External Ceph noarch',
        :name       => 'ext-ceph-dumpling-noarch',
        :baseurl    => 'http://ceph.com/rpm-dumpling/el6/noarch',
        :gpgcheck   => '1',
        :gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
      ) }



    end

    describe "when overriding ceph release" do
      let :params do
        {
         :release => 'emperor'
        }
      end

      it { should contain_yumrepo('ext-ceph').with(
        :descr      => 'External Ceph emperor',
        :name       => 'ext-ceph-emperor',
        :baseurl    => 'http://ceph.com/rpm-emperor/el6/$basearch',
        :gpgcheck   => '1',
        :gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
     ) }

      it { should contain_yumrepo('ext-ceph-noarch').with(
        :descr      => 'External Ceph noarch',
        :name       => 'ext-ceph-emperor-noarch',
        :baseurl    => 'http://ceph.com/rpm-emperor/el6/noarch',
        :gpgcheck   => '1',
        :gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
      ) }
    end

  end

end
