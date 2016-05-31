$LOAD_PATH.push(
  File.join(
    File.dirname(__FILE__),
    '..',
    '..',
    '..',
    'fixtures',
    'modules',
    'inifile',
    'lib')
)

require 'spec_helper'
require 'puppet'

provider_class = Puppet::Type.type(:ceph_config).provider(:ini_setting)

describe provider_class do
  include PuppetlabsSpec::Files

  let(:tmpfile) { tmpfilename("ceph_config_test") }

  let(:params) { {
      :path    => tmpfile,
  } }

  def validate(expected, tmpfile = tmpfile)
    File.read(tmpfile).should == expected
  end

  it 'should create keys = value and ensure space around equals' do
    resource = Puppet::Type::Ceph_config.new(params.merge(
      :name => 'global/ceph_is_foo', :value => 'bar'))
    provider = provider_class.new(resource)
    provider.exists?.should be_nil
    provider.create
    validate(<<-EOS

[global]
ceph_is_foo = bar
    EOS
    )
  end

  it 'should default to file_path if param path is not passed' do
    resource = Puppet::Type::Ceph_config.new(
      :name => 'global/ceph_is_foo', :value => 'bar')
    provider = provider_class.new(resource)
    provider.file_path.should == '/etc/ceph/ceph.conf'
  end

end
