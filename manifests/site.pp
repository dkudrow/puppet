# puppet/manifests/site.pp

$user = 'dkudrow'
$home = "/home/$user"

node 'common' {
  include packages
  include dotfiles
}

node 'chrubuntu' inherits 'common' {
  include c720
}
