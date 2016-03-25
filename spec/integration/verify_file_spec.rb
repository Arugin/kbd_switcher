# encoding: utf-8
require 'spec_helper'

shared_examples 'verify file' do |path|
  corrector = KbdSwitcher::LayoutCorrector.new # it's faster than let

  input_file = File.expand_path(path, __FILE__)

  File.readlines(input_file, encoding: 'UTF-8').each do |line|
    it "expect '#{line}' to be '#{line}' after correction" do
      expect(corrector.correct(line)).to eq(line)
    end
  end
end

describe 'test example lists', integration: true do
  describe '1000 common English words' do
    include_examples 'verify file', '../../files/common_eng_1000.txt'
  end

  describe '1000 common Russian words' do
    include_examples 'verify file', '../../files/common_rus_1000.txt'
  end

  describe '1000 random English words' do
    include_examples 'verify file', '../../files/random_eng_1000.txt'
  end

  describe '1000 random Russian words' do
    include_examples 'verify file', '../../files/random_rus_1000.txt'
  end
end

