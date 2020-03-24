# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DividendDecorator do
  let(:dividend) { Dividend.new.extend DividendDecorator }
  subject { dividend }
  it { should be_a Dividend }
end
