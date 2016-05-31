require 'puppet'
require 'puppet/type/ceph_config'

describe 'Puppet::Type.type(:ceph_config)' do

  before :each do
    @ceph_config = Puppet::Type.type(:ceph_config).new(
      :name => 'global/ceph_is_foo', :value => 'bar')
  end

  it 'should work bascily' do
    @ceph_config[:value] = 'max'
    @ceph_config[:value].should == 'max'
  end

  it 'should convert true to True' do
    @ceph_config[:value] = 'tRuE'
    @ceph_config[:value].should == 'True'
  end

  it 'should convert false to False' do
    @ceph_config[:value] = 'fAlSe'
    @ceph_config[:value].should == 'False'
  end
end
