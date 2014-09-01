# puppet/module/dotfiles/manifests/dotfile.pp
define dotfiles::dotfile ($dir) {
	file { "${dir}/${name}" :
		source => "puppet:///modules/dotfiles/${name}",
	}
	file { "${dir}/${name}.local" :
		ensure => 'present',
	}
}
