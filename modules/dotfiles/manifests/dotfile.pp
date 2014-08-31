# puppet/module/dotfiles/manifests/dotfile.pp
define dotfiles::dotfile ($dir) {
	file { "${dir}/${name}" :
		source => "puppet:///modules/dotfiles/.tmux.conf",
		owner  => "$user",
	}
	file { "${dir}/${name}.local" :
		ensure => 'present',
		owner  => "$user",
	}
}
