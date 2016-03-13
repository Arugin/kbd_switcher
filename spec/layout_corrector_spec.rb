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
        'При', 'рив', 'иве', 'вет', 'ет,', 
        'т, ', ', к', ' ка', 'как', 'ак ', 
        'к д', ' де', 'дел', 'ела', 'ла ', 'а ♪']
      expect(result).to eq(expected_result)
    end
  end

  describe '#credibility' do
    let(:trigramms_probability) {
      {
        'При' => 1, 'рив' => 1, 'иве' => 1, 'вет' => 1, 'ет,' => 1, 
        'т, ' => 1, ', к' => 1, ' ка' => 1, 'как' => 1, 'ак ' => 1, 
        'к д' => 1, ' де' => 1, 'дел' => 1, 'ела' => 1, 'ла ' => 1, 'а ♪' => 1
      }
    }

    before(:each) do
      allow(subject).to receive(:trigramms_probability).and_return(trigramms_probability)
    end

    it 'returns the right credibility for text' do
      result = subject.credibility('Привет, как дела ♪')
      expect(result).to eq(16)
    end

    it 'ignores absent trigramms' do
      result = subject.credibility('Вася! Привет, как дела ♪')
      expect(result).to eq(16)
    end

  end

end
