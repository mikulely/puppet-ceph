require 'spec_helper'

describe 'ceph::mon' do

  describe 'RedHat Family' do

    describe "with custom params" do

      let :facts do
        {
          :operatingsystem     => 'CentOS',
        }
      end

      let :title do
        'A'
      end

      let :params do
        {
          :mon_addr      => '1.2.3.4',
          :key              => '1234',
          'mon_host' => 'A.in',
        }
      end

      it { should contain_service('ceph-mon.A').with('ensure' => "running") }

#      it { p subject.resources }

    end
  end
end

# Local Variables:
# compile-command: "cd ../.. ;
#    export BUNDLE_PATH=/tmp/vendor ;
#    bundle install ;
#    bundle exec rake spec
# "
# End:
