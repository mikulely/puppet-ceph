Puppet::Type.type(:ceph_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do

  def section
    resource[:name].split('/', 2).first
  end

  def setting
    resource[:name].split('/', 2).last
  end

  def separator
    ' = '
  end

  def self.file_path
    '/etc/ceph/ceph.conf'
  end

  # required to be able to hack the path in unit tests
  # also required if a user wants to otherwise overwrite the default file_path
  # Note: purge will not work on over-ridden file_path
  def file_path
    if not resource[:path]
      self.class.file_path
    else
      resource[:path]
    end
  end

end
