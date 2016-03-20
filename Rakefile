# encoding: utf-8
require './lib/kbd_switcher'
require 'json'
require 'unicode'
require 'benchmark'

task :default => [:spec]
desc 'run Rspec specs'
task :spec do
  sh 'rspec spec --tag ~integration'
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
  line_num = 1

  puts "Parsing #{input_file} ..."

  line_count = `wc -l "#{input_file}"`.strip.split(' ')[0].to_i + 1
  puts "Total line count #{line_count}"

  File.open(input_file).readlines.each do |line|
    time = Benchmark.realtime do
      unless line.valid_encoding?
        line = line.encode('UTF-16be', :invalid=>:replace, :replace=>'?').encode('UTF-8')
      end

      while (substring = line.slice!(0..1_000_000)) != ''
        substring.gsub!(Regexp.new(sanitize), ' ')
        substring.gsub!(Regexp.new(white_list), '')

        next if substring.empty?

        generator.get_trigramms(substring).each do |trigram|
          json[Unicode::downcase(trigram)] += 1
          total += 1
        end

        puts "Characters to proceed: #{line.length}" if line.length > 0
      end
    end

    puts "Parsing time #{time} progress: #{line_num += 1}/#{line_count}"
  end

  puts 'Normalizing...'

  json.each do |key, value|
    json[key] = Math.log(value) / Math.log(total)
    json.delete key if json[key] < 0.00001
  end

  puts "Writing results into #{output_file} ..."
  File.open(output_file, 'w') do |f|
    f.write(JSON.pretty_generate(json.sort_by { |_key, value| -value }.to_h))
  end

  puts 'Done.'
end
