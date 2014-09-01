# puppet/modules/dotfiles/manifests/pathogen_plugin.pp
define pathogen_plugin ($url, $bundle) {
	exec { 'Clone Vim Pathogen plugin' :
		command => "git clone ${url} ${bundle}/${name}",
		unless  => "test -d ${bundle}/${name}",
	}
}
