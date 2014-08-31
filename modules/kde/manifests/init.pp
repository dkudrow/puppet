# puppet/module/kde/manifests/init.pp
class kde {
	file { "${home}/.kde" :
		source  => 'puppet:///modules/kde/.kde',
		recurse => 'true',
	}
}
