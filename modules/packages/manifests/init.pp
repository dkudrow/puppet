# puppet/module/packages/manifests/init.pp
class packages {
  $packages = [
    'bash-completion',
    'git',
    'tmux',
    'vim',
    'zsh',
  ]

  package { $packages :
    ensure => 'present',
  }
}
