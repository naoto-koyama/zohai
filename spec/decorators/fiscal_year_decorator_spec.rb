# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FiscalYearDecorator do
  let(:fiscal_year) { FiscalYear.new.extend FiscalYearDecorator }
  subject { fiscal_year }
  it { should be_a FiscalYear }
end
