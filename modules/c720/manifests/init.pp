# puppet/module/c720/manifests/init.pp
class c720 {

  # Fix pm-suspend problems as per 'http://philipalban.wordpress.com/tag/c720/'
  file { '/etc/pm/sleep.d/05_sound' :
    source => 'puppet:///modules/c720/05_sound',
    mode   => 0755,
  }

  file { '/etc/rc.local' :
    source => 'puppet:///modules/c720/rc.local',
    mode   => 0755,
  }

  exec { 'fix_pm_suspend_grub' :
    command => '/bin/sed -i \'s/\(GRUB_CMDLINE_LINUX_DEFAULT=\).*/\1"quiet splash tpm_tis.force=1"/\' /etc/default/grub && /usr/sbin/update-grub && /usr/sbin/update-grub2',
    unless  => '/bin/grep \'GRUB_CMDLINE_LINUX_DEFAULT.*tpm_tis\.force=1\' /etc/default/grub',
  }

  file { '/usr/lib/systemd/system-sleep' :
    ensure => 'directory',
  }

  file { '/usr/lib/systemd/system-sleep/cros-sound-suspend.sh' :
    source => 'puppet:///modules/c720/cros-sound-suspend.sh',
    mode   => 0644,
  }

}
