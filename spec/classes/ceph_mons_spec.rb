require 'spec_helper'

describe 'ceph::mons' do

  let :facts do
    {
      :operatingsystem => 'Ubuntu',
    }
  end

  let :params do
    {
      :args => {
        'A' => {
          'mon_addr' => '1.2.3.4',
          'key' => '1234',
          'mon_host' => 'A.in',
        },
      },
    }
  end

  it {
    should contain_service('ceph-mon.A').with('ensure' => "running")
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
