# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kbd_switcher/kbd_switcher_module'

Gem::Specification.new do |gem|
  gem.name        = 'kbd_switcher'
  gem.version     = KbdSwitcher::VERSION
  gem.homepage    = 'https://github.com/denisovlev/kbd_switcher'

  gem.authors      = ['Lev Denisov', 'Valery Mayatsky', 'Dmitriy Egunov']
  gem.email       = 'denisovlev@ya.ru'
  gem.description = 'Switch the keyboard layout of string from English to Russian and vice versa'
  gem.summary     = 'Switch the keyboard layout of string from English to Russian and vice versa'

  # Gem dependencies goes here
  gem.add_dependency 'json'
  gem.add_dependency 'unicode'
  #gem.add_development_dependency 'bundler', '~> 1.0'

  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.require_paths = ['lib']
end
