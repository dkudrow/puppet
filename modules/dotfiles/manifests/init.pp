# puppet/module/dotfiles/manifests/init.pp
class dotfiles {
	# tmux
	dotfile { '.tmux.conf' :
		dir => "${home}",
	}

	# vim
	dotfile { '.vimrc' :
		dir => "${home}",
	}

	file { [ "${home}/.vim", "${home}/.vim/autoload", "${home}/.vim/bundle", "${home}/.vim/templates" ] :
		ensure => 'directory',
		owner  => "${user}",
	}

	file { "${home}/.vim/autoload/pathogen.vim" :
		source => 'puppet:///modules/dotfiles/pathogen/pathogen.vim',
		owner  => "${user}",
	}

	file { $pathogen_plugins :
		path    => "${home}/.vim/bundle/${name}",
		source  => "puppet:///modules/dotfiles/${name}",
		recurse => 'true',
	}

	# zsh
	dotfile { '.zshrc' :
		dir => "${home}",
	}

	file { "oh-my-zsh" :
		path    => "${home}/.oh-my-zsh",
		recurse => 'true',
	}

	# bash
	dotfile { '.bashrc' :
		dir => "${home}",
	}

	file { "${home}/.bash_aliases" :
		source => 'puppet:///modules/dotfiles/.bash_aliases',
		owner  => "${user}",
	}

	# pianobar
	file { [ "${home}/.config/", "${home}/.config/pianobar" ] :
		ensure => 'directory',
		owner  => "${user}",
	}

	file { "${home}/.config/pianobar/config" :
		source => 'puppet:///modules/pianobar/pianobar.config',
		owner  => "${user}",
	}
}
