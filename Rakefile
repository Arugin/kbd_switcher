# encoding: utf-8
require './lib/kbd_switcher'
require 'json'
require 'unicode'

task :default => [:spec]
desc 'run Rspec specs'
task :spec do
  sh 'rspec spec'
end

desc 'generate trigrams list from text file'
task :generate_trigrams, [:input, :output, :white_list, :sanitize] do |_t, args|
  input_file = args.input || 'input.txt'
  output_file = args.output || 'trigrams.json'
  white_list = args.white_list || '[^А-Яа-я ]'
  sanitize = args.sanitize || '[,.:;\-)(\[\]\\/><\'"]'

  json = Hash.new(0)
  total = 0.0
  generator = LayoutCorrector.new

  puts "Parsing #{input_file} ..."
  File.open(input_file).readlines.each do |line|
    line.gsub!(Regexp.new(sanitize), ' ')
    line.gsub!(Regexp.new(white_list), '')
    next if line.empty?

    generator.get_trigramms(line).each do |trigram|
      json[Unicode::downcase(trigram)] += 1
      total += 1
    end
  end

  puts 'Normalizing...'

  json.each do |key, value|
    json[key] = value / total
    json.delete key if json[key] < 0.00001
  end

  puts "Writing results into #{output_file} ..."
  File.open(output_file, 'w') do |f|
    f.write(JSON.pretty_generate(json.sort_by { |_key, value| -value }.to_h))
  end

  puts 'Done.'
end
