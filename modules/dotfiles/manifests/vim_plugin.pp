# puppet/modules/dotfiles/manifests/vim_plugin.pp
define vim_plugin ($url) {
	exec {
		command => "git clone ${url} ${dir}/${name}"
		unless  => "test -d ${dir}/${name}"
	}
}
