require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

PACKAGE_MANAGERS = [
  {
    install: 'pacman -Syu $_PKG',
    check: -> { command? 'pacman' },
    name: :pacman
  }, {
    install: 'apt-get install $_PKG',
    check: -> { command? 'apt-get' },
    name: :apt
  }, {
    install: 'brew install $_PKG',
    check: -> { command? 'brew' },
    name: :brew
  }, {
    install: "zsh -c '$_PKG'",
    check: -> { true },
    name: :shell
  }
]

module Console
  module_function
  def group(text)
    $stderr.puts Paint["==> #{text}", :bright]
  end

  def log(text)
    $stderr.puts Paint[text, :bright]
  end

  def warn(text)
    $stderr.puts Paint["⚠️ #{text}", :yellow]
  end

  def error(text)
    $stderr.puts Paint["❌ #{text}", :red]
  end

  def info(text)
    $stderr.puts Paint["ℹ️ #{text}", :bright]
  end
end

# Detect if a command is available
def command?(name)
  `which #{name}`
  $?.success?
end

# Clones a git repository
def git_clone(remote, dest)
  Dir.chdir(__dir__) do
    system "git clone #{remote} #{dest}"
  end
end

def symlink_into_homedir(src, dest = ".#{File.basename(src)}")
  Console.log "Symlinking #{dest} to #{src}"
  src = File.join(__dir__, src)
  dest = File.join(ENV['HOME'], dest)
  File.delete(dest) if File.exist?(dest)
  File.symlink(src, dest)
end

# Install a package
def install_package(name, packages = nil)
  if packages
    package_manager = available_package_managers.find { |man| packages.has_key?(man[:name]) }
    return Console.error "Could not find package for #{name}" unless package_manager
    package_name = packages[package_manager[:name].to_sym]
    Console.group "Installing #{name} via #{package_manager[:name]}"
    cmd = package_manager[:install].sub('$_PKG', package_name)
    Dir.chdir(__dir__) do
      system cmd
    end
  else
    install_package(name, {
      available_package_managers.first[:name].to_sym => name
    })
  end
end

def available_package_managers
  @available_package_managers ||= PACKAGE_MANAGERS.select { |man| man[:check].call() }
end
