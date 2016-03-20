# Keyboard Switcher [![Build Status](https://travis-ci.org/denisovlev/kbd_switcher.svg?branch=master)](https://travis-ci.org/denisovlev/kbd_switcher)

Keyboard Switcher is a library to switch keyboard layout in already typed text, for example: 'Ghbdtn' -> 'Привет'.

## Installation

Gem release in progress, so

```ruby
gem 'kbd_switcher', git: 'https://github.com/denisovlev/kbd_switcher.git'
```

## Usage

```ruby
require 'kbd_switcher'

corrector = KbdSwitcher::LayoutCorrector.new
corrector.correct('Ghbdtn') #=> "Привет"
```
