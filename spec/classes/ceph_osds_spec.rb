require 'spec_helper'

describe 'ceph::osds' do

  let :facts do
    {
      :operatingsystem => 'CentOS',
      :ceph_osd_id_APPLE_DEV => '0',
      :ceph_osd_id_BANANE_DEV => '1',
    }
  end

  let :params do
    {
      :args => {
        'APPLE_DEV' => {
          'osd_journal_size' => '2048',
          'osd_journal' => '/dev/sdx',
        },
        'BANANE_DEV' => {
          'osd_journal_size' => '2048',
          'osd_journal' => '/dev/sdy',
        },
      },
    }
  end

  it {
    should contain_service('ceph-osd.0').with('ensure' => "running")
    should contain_service('ceph-osd.1').with('ensure' => "running")
  }

#  it { p subject.resources }

end

# Local Variables:
# compile-command: "cd ../.. ;
#    export BUNDLE_PATH=/tmp/vendor ;
#    bundle install ;
#    bundle exec rake spec
# "
# End:
