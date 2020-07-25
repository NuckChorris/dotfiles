task :default => %i[install configure]

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
    zshdir = File.join(__dir__, 'zsh')
    zsh "antibody bundle < #{zshdir}/plugins.txt > #{zshdir}/plugins.zsh"
  end

  desc 'Installs the Atom configuration'
  task :atom do
    atomdir = File.join(__dir__, 'atom')
    zsh "apm install --packages-file #{atomdir}/packages.txt"
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
    FileUtils.mkdir_p(File.join(ENV['HOME'], '.config'))
    symlink_into_homedir 'awesome', '.config/awesome'
  end

  desc 'Installs the X11 configuration'
  task :xorg do
    symlink_into_homedir 'xorg/xmodmap'
    symlink_into_homedir 'xorg/xprofile'
    symlink_into_homedir 'xorg/xresources'
  end

  desc 'Installs the MPV configuration'
  task :mpv do
    symlink_into_homedir 'mpv'
  end
end

desc "Installs the required applications using the system package manager"
task :install => %i[
  install:zsh install:tmux install:docker install:chrome install:gnu_coreutils
  install:git install:atom install:iterm2
]

namespace :install do
  desc 'Package Manager'
  task :package_manager do
    install_package_manager!
  end

  desc 'Installs fonts'
  task :fonts do
    install_package brew: 'homebrew/cask-fonts/font-iosevka'
  end

  desc 'Installs Atom'
  task :atom do
    install_package brew: 'caskroom/cask/atom-beta'
  end

  desc 'Installs iTerm2'
  task :iterm2 do
    install_package brew: 'caskroom/cask/iterm2'
  end

  desc 'Installs zsh'
  task :zsh do
    install_package 'zsh'
    install_package shell: 'curl -sfL git.io/antibody | sh -s - -b /usr/local/bin'
  end

  desc 'Installs tmux'
  task :tmux do
    install_package 'tmux'
  end

  desc 'Installs Docker'
  task :docker do
    install_package brew: 'caskroom/cask/docker',
                    apt: 'docker',
                    pacman: 'docker'
  end

  desc 'Installs Google Chrome'
  task :chrome do
    install_package brew: 'caskroom/cask/google-chrome',
                    apt: 'google-chrome',
                    pacman: 'chromium'
  end

  desc 'Installs the GNU Coreutils for MacOS'
  task :gnu_coreutils do
    install_package brew: 'coreutils' if os == :macos
  end

  desc 'Installs Git'
  task :git do
    install_package 'git'
  end
end

###########################################################
### Utilities
###########################################################

def command?(name)
  `which #{name}`
  $?.success?
end

def os
  @os ||= (
    case RbConfig::CONFIG['host_os']
    when /darwin|mac os/ then :macos
    when /linux/ then :linux
    when /solaris|bsd/ then :unix
    end
  )
end

def git_clone(remote, dest)
  system "git clone #{remote} #{dest}"
end

def say(text)
  $stderr.puts "==> #{text}"
end

def zsh(command)
  system "zsh -c '#{command}'"
end

###########################################################
### Package Manager Code
###########################################################

PACKAGE_MANAGERS = [
  {
    install: 'pacman -Syu $_PKG',
    check: -> { command? 'pacman' },
    name: 'pacman'
  }, {
    install: 'apt-get install $_PKG',
    check: -> { command? 'apt-get' },
    name: 'apt'
  }, {
    install: 'brew install $_PKG',
    check: -> { command? 'brew' },
    name: 'brew'
  }, {
    install: '$_PKG',
    check: -> { true },
    name: 'shell'
  }
].map { |hash| OpenStruct.new(hash) }

def available_package_managers
  @available_package_managers ||= PACKAGE_MANAGERS.select { |man| man.check.() }
end

def package_manager
  @package_manager ||= available_package_managers.first
end

def package_manager!
  if package_manager
    package_manager
  else
    install_package_manager!
  end
end

def install_package_manager!
  if os == :macos
    say 'Installing Homebrew...'
    system '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  else
    raise 'Cannot find package manager'
  end
end

def install_package(package)
  if package.is_a?(Hash)
    package_manager = available_package_managers.find { |key| package.has_key?(key) }
    package_name = package[package_manager[:name].to_sym] if package.is_a? Hash
    raise 'Could not find package for system' unless package_name
    say "Installing #{package_name} via #{package_manager[:name]}"
    cmd = package_manager.install.sub('$_PKG', package_name)
    system cmd
  else
    hash = {}
    hash[package_manager[:name]] = package
    install_package(hash)
  end
end

###########################################################
### Configuration Code
###########################################################

def symlink_into_homedir(src, dest = ".#{File.basename(src)}")
  say "Symlinking #{dest} to #{src}"
  src = File.join(__dir__, src)
  dest = File.join(ENV['HOME'], dest)
  File.delete(dest) if File.exist?(dest)
  File.symlink(src, dest)
end
