require './utils'

task :default => %i[install:package_manager install configure]

desc "Installs the required applications using the system package manager"
task :install => %i[
  install:zsh install:tmux install:docker install:chrome install:gnu_coreutils
  install:git install:atom install:iterm2
]

namespace :install do
  desc 'Package Manager'
  task :package_manager do
    next unless OS.mac?
    next if command?('brew')

    install_package 'Homebrew',
      shell: 'curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash'
  end

  desc 'Installs DisplayLink Drivers'
  task :displaylink do
    install_package 'DisplayLink Drivers',
      brew: 'homebrew/cask-drivers/displaylink'
  end

  desc 'Installs fonts'
  task :fonts do
    install_package 'Iosevka',
      brew: 'homebrew/cask-fonts/font-iosevka'
  end

  desc 'Installs Atom'
  task :atom do
    next if command?('atom')

    install_package 'Atom',
      brew: 'homebrew/cask/atom',
      pacman: 'atom',
      apt: 'atom'
  end

  desc 'Installs iTerm2'
  task :iterm2 do
    install_package 'iTerm 2',
      brew: 'homebrew/cask/iterm2'
  end

  desc 'Installs zsh'
  task :zsh do
    next if command?('zsh')

    install_package 'zsh'
    install_package 'antibody',
      shell: 'curl -sfL git.io/antibody | sh -s - -b /usr/local/bin'
  end

  desc 'Installs tmux'
  task :tmux do
    next if command?('tmux')

    install_package 'tmux'
  end

  desc 'Installs Docker'
  task :docker do
    next if command?('docker')

    install_package 'Docker',
      brew: 'homebrew/cask/docker',
      apt: 'docker',
      pacman: 'docker'
  end

  desc 'Installs Google Chrome'
  task :chrome do
    install_package 'Google Chrome',
      brew: 'homebrew/cask/google-chrome',
      apt: 'google-chrome',
      pacman: 'chromium'
  end

  desc 'Installs Firefox'
  task :firefox do
    install_package 'Mozilla Firefox',
      brew: 'homebrew/cask/firefox'
  end

  desc 'Installs Slack'
  task :slack do
    install_package 'Slack',
      brew: 'homebrew/cask/slack'
  end

  desc 'Installs Discord'
  task :discord do
    install_package 'Discord',
      brew: 'homebrew/cask/discord'
  end

  desc 'Installs 1Password'
  task :onepassword do
    install_package '1Password',
      brew: 'homebrew/cask/1password'
  end

  desc 'Installs Bartender 3'
  task :bartender do
    next unless OS.mac?

    install_package 'Bartender',
      brew: 'homebrew/cask/bartender'
  end

  desc 'Installs the GNU Coreutils for MacOS'
  task :gnu_coreutils do
    next unless OS.mac?

    install_package 'GNU Coreutils',
      brew: 'coreutils'
  end

  desc 'Installs Git'
  task :git do
    install_package 'git'
  end

  desc 'Installs The Silver Searcher'
  task :ag do
    next if command?('ag')

    install_package 'The Silver Searcher',
      brew: 'the_silver_searcher',
      apt: 'silversearcher-ag',
      pacman: 'the_silver_searcher'
  end

  desc 'Installs Karabiner Elements'
  task :karabiner do
    next unless OS.mac?

    install_package 'Karabiner Elements',
      brew: 'homebrew/cask/karabiner-elements'
  end

  desc 'Installs GnuPG'
  task :gnupg do
    install_package 'GnuPG',
      brew: 'gnupg',
      pacman: 'gnupg',
      apt: 'gnupg'
  end

  desc 'Installs RVM'
  task :rvm => %i[gnupg] do
    install_package 'RVM Keys',
      shell: 'gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
    install_package 'RVM',
      shell: 'curl -sSL https://get.rvm.io | bash -s stable'
  end
end


desc "Copies the configuration files into the user's home directory"
task :configure => %i[
  configure:zsh configure:tmux configure:vim configure:git configure:awesome configure:xorg
  configure:mpv configure:atom
]

namespace :configure do
  desc 'Installs the zsh configuration'
  task :zsh do
    symlink_into_homedir 'zsh/zshrc'
    symlink_into_homedir 'zsh'
    install_package 'Antibody Plugins',
      shell: "antibody bundle < ./zsh/plugins.txt > ./zsh/plugins.zsh"
  end

  desc 'Installs the Atom configuration'
  task :atom do
    install_package 'Atom Packages',
      shell: "apm install --packages-file ./atom/packages.txt"
  end

  desc 'Installs the tmux configuration'
  task :tmux do
    symlink_into_homedir 'tmux/tmux.conf'
  end

  desc 'Installs the Vim configuration'
  task :vim do
    symlink_into_homedir 'vim/vimrc'
    symlink_into_homedir 'vim'
  end

  desc 'Installs the Git configuration'
  task :git do
    symlink_into_homedir 'git/gitconfig'
    symlink_into_homedir 'git/gitignore_global'
  end

  desc 'Installs the AwesomeWM configuration'
  task :awesome do
    next if command?('Xorg')

    FileUtils.mkdir_p(File.join(ENV['HOME'], '.config'))
    symlink_into_homedir 'awesome', '.config/awesome'
  end

  desc 'Installs the X11 configuration'
  task :xorg do
    next if command?('Xorg')

    symlink_into_homedir 'xorg/xmodmap'
    symlink_into_homedir 'xorg/xprofile'
    symlink_into_homedir 'xorg/xresources'
  end

  desc 'Installs the MPV configuration'
  task :mpv do
    symlink_into_homedir 'mpv'
  end
end
