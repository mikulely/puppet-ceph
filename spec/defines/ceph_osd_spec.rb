require 'spec_helper'

describe 'ceph::osd' do

  describe 'Redhat Family' do

    describe "with custom params" do

      let :facts do
        {
          :operatingsystem     => 'CentOS',
          :ceph_osd_id_FOO_DEV => '0',
        }
      end

      let :title do
        'FOO_DEV'
      end

      let :params do
        {
          :osd_journal         => 'boo_dev'
        }
      end

      it { should contain_service('ceph-osd.0').with('ensure' => "running") }

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
