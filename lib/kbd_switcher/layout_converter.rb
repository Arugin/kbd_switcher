# encoding: utf-8

class KbdSwitcher::LayoutConverter
  LOWER_IDENTITY = {
      'q' => 'й', 'w' => 'ц', 'e' => 'у', 'r' => 'к',
      't' => 'е', 'y' => 'н', 'u' => 'г', 'i' => 'ш',
      'o' => 'щ', 'p' => 'з', '[' => 'х', ']' => 'ъ',
      'a' => 'ф', 's' => 'ы', 'd' => 'в', 'f' => 'а',
      'g' => 'п', 'h' => 'р', 'j' => 'о', 'k' => 'л',
      'l' => 'д', ';' => 'ж', "'" => 'э', 'z' => 'я',
      'x' => 'ч', 'c' => 'с', 'v' => 'м', 'b' => 'и',
      'n' => 'т', 'm' => 'ь', ',' => 'б', '.' => 'ю',
      '/' => '.', '`' => 'ё'
  }

  UPPER_IDENTITY = {
      'Q' => 'Й', 'W' => 'Ц', 'E' => 'У', 'R' => 'К',
      'T' => 'Е', 'Y' => 'Н', 'U' => 'Г', 'I' => 'Ш',
      'O' => 'Щ', 'P' => 'З', '{' => 'Х', '}' => 'Ъ',
      'A' => 'Ф', 'S' => 'Ы', 'D' => 'В', 'F' => 'А',
      'G' => 'П', 'H' => 'Р', 'J' => 'О', 'K' => 'Л',
      'L' => 'Д', ':' => 'Ж', '"' => 'Э', 'Z' => 'Я',
      'X' => 'Ч', 'C' => 'С', 'V' => 'М', 'B' => 'И',
      'N' => 'Т', 'M' => 'Ь', '<' => 'Б', '>' => 'Ю',
  }

  SPECIAL_IDENTITY = {
      '@' => '"', '#' => '№', '$' => ';', '^' => ':',
      '&' => '?', '?' => ',', '~'=>'Ё'
  }

  LAYOUT_IDENTITY = LOWER_IDENTITY.merge(UPPER_IDENTITY).merge(SPECIAL_IDENTITY)

  LAYOUTS = {
    en_ru: LAYOUT_IDENTITY.invert.merge(LAYOUT_IDENTITY),
    ru_en: LAYOUT_IDENTITY.merge(LAYOUT_IDENTITY.invert)
  }

  class << self
    def convert(text, options = {})
      from = options.fetch(:from)
      to = options.fetch(:to)
      converter = LAYOUTS["#{from}_#{to}".to_sym]
      raise "Cannot convert from #{from} to #{to}" if converter.nil?
      text.split("").map {|char| converter[char] || char }.join("")
    end
  end

end
  