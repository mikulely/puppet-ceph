require 'spec_helper'

describe 'ceph::pool' do

  describe 'RedHat Family' do

    describe "with custom params" do

      let :facts do
        {
          :operatingsystem => 'CentOS',
        }
      end

      let :title do
        'openstack'
      end

      it { should contain_exec('create-pool-openstack') }

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
