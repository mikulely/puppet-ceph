Puppet::Type.newtype(:ceph_config) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage from ./ceph.conf'
    newvalues(/\S+\/\S+/)
  end

  # required in order to be able to unit test file contents
  # Note: purge will not work on over-ridden file_path
  # lifted from ini_file
  newparam(:path) do
    desc 'A file path to over ride the default file path if necessary'
    validate do |value|
      unless (Puppet.features.posix? and value =~ /^\//) or (Puppet.features.microsoft_windows? and (value =~ /^.:\// or value =~ /^\/\/[^\/]+\/[^\/]+/))
        raise(Puppet::Error, "File paths must be fully qualified, not '#{value}'")
      end
    end
    defaultto false
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined.'
    munge do |value|
      value = value.to_s.strip
      value.capitalize! if value =~ /^(true|false)$/i
      value
    end
  end
end
