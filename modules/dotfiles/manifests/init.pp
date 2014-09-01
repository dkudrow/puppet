# puppet/module/dotfiles/manifests/init.pp
class dotfiles {

  # Resource defaults
  File {
    owner => "${user}",
    group => "${user}",
  }

  Exec {
    user => "${user}",
  }

  # Tmux
  dotfile { '.tmux.conf' :
    dir => "${home}",
  }

  # Vim
  dotfile { '.vimrc' :
    dir => "${home}",
  }

  file { [ "${home}/.vim", "${home}/.vim/autoload", "${home}/.vim/bundle", "${home}/.vim/templates" ] :
    ensure => 'directory',
  }

  exec { 'Install Pathogen' :
    command => "/usr/bin/wget -O ${home}/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim",
    creates => "${home}/.vim/autoload/pathogen.vim",
    require => File["${home}/.vim/autoload"],
  }

  $pathogen_defaults = {
    ensure   => 'present',
    provider => 'git',
    owner => "${user}",
    group => "${user}",
  }

  $pathogen_plugins = {
    "${home}/.vim/bundle/nerdtree" => { 'source' => 'https://github.com/scrooloose/nerdtree.git'},
    "${home}/.vim/bundle/nerdcommenter" => { 'source' => 'https://github.com/scrooloose/nerdcommenter.git'},
    "${home}/.vim/bundle/puppet-syntax-vim" => { 'source' => 'https://github.com/puppetlabs/puppet-syntax-vim.git'}
  }

  create_resources(vcsrepo, $pathogen_plugins, $pathogen_defaults)

  # zsh
  dotfile { '.zshrc' :
    dir => "${home}",
  }

  vcsrepo { "${home}/.oh-my-zsh" :
    ensure   => 'present',
    provider => 'git',
    owner    => "${user}",
    group    => "${user}",
    source   => 'https://github.com/robbyrussell/oh-my-zsh.git',
  }

  # bash
  dotfile { '.bashrc' :
    dir => "${home}",
  }

  file { "${home}/.bash_aliases" :
    source => 'puppet:///modules/dotfiles/.bash_aliases',
  }

  # pianobar
  file { [ "${home}/.config/", "${home}/.config/pianobar" ] :
    ensure => 'directory',
  }

  file { "${home}/.config/pianobar/config" :
    source  => 'puppet:///modules/dotfiles/pianobar.config',
    require => File["${home}/.config/pianobar"],
  }
}
