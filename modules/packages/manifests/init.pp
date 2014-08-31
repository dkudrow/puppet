# puppet/module/packages/manifests/init.pp
class packages {
	$packages = [ 'git', 'vim' , 'tmux', 'bash-completion' ]

	package { $packages :
		ensure => 'present',
	}
}
