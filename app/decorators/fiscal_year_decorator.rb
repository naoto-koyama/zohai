module FiscalYearDecorator
  def display_fiscal_year
    fiscal_year&.strftime("%Y%m")
  end
end
