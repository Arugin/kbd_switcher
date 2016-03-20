# encoding: utf-8

require 'spec_helper'

describe KbdSwitcher::LayoutConverter do
  describe '.convert' do
    it 'converts from ru to en' do
      converted = described_class.convert('фц ытфз', from: 'ru', to: 'en')
      expect(converted).to eq('aw snap')
    end

    it 'converts from en to ru' do
      converted = described_class.convert('ghbdtn rfr ltkf', from: 'en', to: 'ru')
      expect(converted).to eq('привет как дела')
    end

    it 'does not change unknown characters from ru to en' do
      converted = described_class.convert('♪♣', from: 'ru', to: 'en')
      expect(converted).to eq('♪♣')
    end

    it 'does not change unknown characters from en to ru' do
      converted = described_class.convert('♪♣', from: 'en', to: 'ru')
      expect(converted).to eq('♪♣')
    end

    it 'throws error for unknown from/to' do
      expect{ described_class.convert('ghbdtn rfr ltkf', from: 'fr', to: 'ru') }.to raise_error
    end

    it 'works correctly with capital letters from ru to en' do
      converted = described_class.convert('Фц Ытфз', from: 'ru', to: 'en')
      expect(converted).to eq('Aw Snap')
    end

    it 'works correctly with capital letters from en to ru' do
      converted = described_class.convert('Ghbdtn rfr Ltkf', from: 'en', to: 'ru')
      expect(converted).to eq('Привет как Дела')
    end

    it 'works correctly with special characters from ru to en' do
      converted = described_class.convert('!"№;%:?*()_+.,', from: 'ru', to: 'en')
      expect(converted).to eq('!@#$%^&*()_+/?')
    end

    it 'works correctly with special characters from en to ru' do
      converted = described_class.convert('!@#$%^&*()_+[{]};:\'",<.>/?`~', from: 'en', to: 'ru')
      expect(converted).to eq('!"№;%:?*()_+хХъЪжЖэЭбБюЮ.,ёЁ')
    end

    it 'does not change numbers from ru to en' do
      converted = described_class.convert("1234567890", from: 'ru', to: 'en')
      expect(converted).to eq("1234567890")
    end

    it 'does not change numbers from en to ru' do
      converted = described_class.convert("1234567890", from: 'en', to: 'ru')
      expect(converted).to eq("1234567890")
    end

    it 'works with mixed layout from ru to en' do
      converted = described_class.convert("руддщб dfcz", from: 'ru', to: 'en')
      expect(converted).to eq("hello, вася")
    end

    it 'works with mixed layout from en to ru' do
      converted = described_class.convert("ghbdtn гыуктфьу", from: 'en', to: 'ru')
      expect(converted).to eq("привет username")
    end
  end
end
