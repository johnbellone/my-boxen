class people::johnbellone {
  include emacs
  include flux
  include tmux
  include java
  include vagrant
  include virtualbox
  include vmware_fusion
  include iterm2::stable
  include iterm2::dev
  include chrome
  include wget
  include vlc
  include caffeine
  include gh
  include inconsolata

  include osx::software_update
  osx::recovery_message { 'If found, please call +1 6098571012': }

  include osx::global::enable_keyboard_control_access
  include osx::no_network_dsstores
  include osx::dock::dim_hidden_apps
  class { 'osx::dock::icon_size':
    size => 42
  }

  boxen::osx_defaults {
    "Disable 'natural scrolling'":
      ensure => present,
      key    => 'com.apple.swipescrolldirection',
      domain => 'NSGlobalDomain',
      user   => $::boxen_user,
      value  => 'false',
      type   => 'bool';
    "Set aqua color variant to graphite":
      ensure => present,
      key    => 'AppleAquaColorVariant',
      domain => 'NSGlobalDomain',
      user   => $::boxen_user,
      type   => 'int',
      value  => 6;
    "disables Dashboard":
      user   => $::boxen_user,
      domain => 'com.apple.dashboard',
      key    => 'mcx-disabled',
      value  => true;
  }
  ~> exec { 'killall Finder':
    refreshonly => true
  }

  include go
  go::version { '1.1.2': }

  include nodejs::v0_10
  class { 'nodejs::global':
    version => 'v0.10'
  }
  nodejs::module { 'bower':
    node_version => 'v0.10'
  }

  # Setup and install all rubies and plugins for rbenv.
  ruby::plugin { 'rbenv-vars':
    ensure => 'present',
    source => 'sstephenson/rbenv-vars'
  }

  ruby::plugin { 'rbenv-ctags':
    ensure => 'present',
    source => 'tpope/rbenv-ctags'
  }

  ruby::plugin { 'rbenv-use':
    ensure => 'present',
    source => 'rkh/rbenv-use'
  }

  ruby::plugin { 'rbenv-update':
    ensure => 'present',
    source => 'rkh/rbenv-update'
  }
  -> exec { "env -i bash -c 'source /opt/boxen/env.sh && rbenv update'":
    provider => 'shell'
  }

  ruby::version { '1.9.3-p484': }
  ruby::version { '2.0.0-p353': }
  class { 'ruby::global':
    version => '1.9.3-p484'
  }

  # Base configuration for Git.
  git::config::global {
    'user.name':
      value => 'John Bellone';
    'user.email':
      value => 'john.bellone.jr@gmail.com';
    'color.ui':
      value => 'true';
  }

}
