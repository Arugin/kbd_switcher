# encoding: utf-8
require 'spec_helper'

describe 'Known failures', integration: true do
  let!(:corrector) { KbdSwitcher::LayoutCorrector.new }

  data = JSON.parse(File.read('spec/files/known_failures.json'))

  data.each do |initial, expected|
    it "expect '#{initial}' to be '#{expected}' after correction" do
      expect(corrector.correct(initial)).to eq(expected)
    end
  end
end
