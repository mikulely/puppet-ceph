
require 'facter'
require 'timeout'

timeout = 3

begin
    Timeout::timeout(timeout) {

        blkid = Facter::Util::Resolution.exec("ls -l  /dev/disk/by-id/ | awk '{print $9,$11}'")
        #blkid = Facter::Util::Resolution.exec("cat /root/zhu/fake-wwn.txt | awk '{print $9,$11}'")
        blkid and blkid.each_line do |line|
            if line =~ /^(wwn-.+) \.\.\/\.\.\/([a-zA-Z0-9]+)/
                disk_id = $1
                label = $2
                disk_label = "/dev/#{label}"

                Facter.add("disk_label_#{disk_id}") do
                    setcode do
                        disk_label
                    end
                end

            end
        end

        ceph_osds = Hash.new
        ceph_osd_dump = Facter::Util::Resolution.exec("timeout #{timeout} \
        ceph osd dump \
        --name client.admin \
        --keyring /etc/ceph/ceph.client.admin.keyring 2>/dev/null ")
        ceph_osd_dump and ceph_osd_dump.each_line do |line|
            if line =~ /^osd\.(\d+).* ([a-f0-9\-]+)$/
                ceph_osds[$2] = $1
            end
        end

        blkid = Facter::Util::Resolution.exec("blkid")
        blkid and blkid.each_line do |line|
        #    if line =~ /^\/dev\/(.+):.*UUID="([a-fA-F0-9\-]+)"/
            if line =~ /^(\/dev\/.+):.*UUID="([a-fA-F0-9\-]+)"/
                device = $1
                uuid = $2

                Facter.add("blkid_uuid_#{device}") do
                    setcode do
                        uuid
                    end
                end

                Facter.add("ceph_osd_id_#{device}") do
                    setcode do
                        ceph_osds[uuid]
                    end
                end

                Facter.add("disk_label_#{uuid}") do
                    setcode do
                        device
                    end
                end
            end
        end

    }

rescue Timeout::Error
    Facter.warnonce('ceph command timeout in ceph_admin_key fact')
end



