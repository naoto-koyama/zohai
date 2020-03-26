# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrandLatestDividendDecorator do
  let(:fiscal_year) { FiscalYear.new.extend BrandLatestDividendDecorator }
  subject { fiscal_year }
  it { should be_a FiscalYear }
end
