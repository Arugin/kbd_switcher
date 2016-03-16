# encoding: utf-8
require 'json'
require 'unicode'

class LayoutCorrector
  # @trigramms_probability {Hash}
  attr_reader :trigramms_probability

  def initialize(config = {})
    @trigramms_probability = config.fetch(:trigramms, nil)
    if trigramms_probability.nil?
      ru_default_trigramms_path = File.expand_path('../../../config/ru_default_trigramms.json', __FILE__)
      en_default_trigramms_path = File.expand_path('../../../config/en_default_trigramms.json', __FILE__)
      ru_default_trigramms = JSON.parse(File.read(ru_default_trigramms_path))
      en_default_trigramms = JSON.parse(File.read(en_default_trigramms_path))
      @trigramms_probability = ru_default_trigramms.merge(en_default_trigramms)
    end
  end

  def correct(text)
    ru_en = LayoutConverter.convert(text, from: 'ru', to: 'en')
    en_ru = LayoutConverter.convert(text, from: 'en', to: 'ru')
    possible_texts = [text, ru_en, en_ru]
    credibilities = possible_texts.map do |t|
      credibility(t)
    end
    largest_credibility, text_index = credibilities.each_with_index.max
    return text unless largest_credibility > 0
    possible_texts[text_index]
  end

  def credibility(text)
    get_trigramms(text).reduce(0) do |sum, ngram|
      sum + (trigramms_probability[ngram] || 0)
    end
  end

  def get_trigramms(text)
    string = Unicode::downcase(text)
    sanitize!(string)

    return []             if string.length <= 1
    return ["#{string} "] if string.length == 2
    return [string]       if string.length == 3

    string.split('').each_cons(3).map do |ngram|
      trigram = ngram.join('')
      next if trigram.strip.length == 1

      trigram
    end.compact
  end

  def sanitize!(string)
    string.gsub!(/[,.:;\-)(\[\]\/><'"\\]/, ' ')
    string.squeeze!(' ')
    string.strip!
    string.gsub!(/[^a-zA-Zа-яА-Я ]/, '')
  end
end