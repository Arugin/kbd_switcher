# encoding: utf-8

require 'spec_helper'

describe LayoutCorrector do
  subject { LayoutCorrector.new }

  describe '#convert' do

    let(:trigramms_probability) {
      {
        'при' => 9, 
        'оло' => 10, 
        'the' => 10, 
        'ing' => 9
      }
    }

    before(:each) do
      allow(subject).to receive(:trigramms_probability).and_return(trigramms_probability)
    end
    
    it 'corrects english text with russian layout' do
      result = subject.correct('еру иупшттштп')
      expect(result).to eq('the beginning')
    end

    it 'corrects russian text with english layout' do
      result = subject.correct('ghbdtn jkjkj')
      expect(result).to eq('привет ололо')
    end

    it 'leaves as is english text with english layout' do
      result = subject.correct('worst nightmare')
      expect(result).to eq('worst nightmare')
    end

    it 'leaves as is russian text with russian layout' do
      result = subject.correct('худший кошмар')
      expect(result).to eq('худший кошмар')
    end

    it 'corrects text with mixed layout' do
      result = subject.correct('еру иупшттштп ща ghbdtn')
      expect(result).to eq('the beginning of привет')
    end

  end

  describe '#get_trigramms' do
    it 'returns the right trigramms for text' do
      result = subject.get_trigramms('Привет, как дела ♪')
      expected_result = [
          'при', 'рив', 'иве', 'вет', 'ет ',
          'т к', ' ка', 'как', 'ак ', 'к д',
          ' де', 'дел', 'ела', 'ла '
      ]
      expect(result).to eq(expected_result)
    end
  end

  describe '#credibility' do
    let(:trigramms_probability) {
      trigrams = [
          'при', 'рив', 'иве', 'вет', 'ет ',
          'т к', ' ка', 'как', 'ак ', 'к д',
          ' де', 'дел', 'ела', 'ла '
      ]
      Hash[trigrams.map { |t| [t, 1] }] # { key1: 1, key2: 1 ... }
    }

    before(:each) do
      allow(subject).to receive(:trigramms_probability).and_return(trigramms_probability)
    end

    it 'returns the right credibility for text' do
      result = subject.credibility('Привет, как дела ♪')
      expect(result).to eq(14)
    end

    it 'ignores absent trigramms' do
      result = subject.credibility('Вася! Привет, как дела ♪')
      expect(result).to eq(14)
    end

  end

end
