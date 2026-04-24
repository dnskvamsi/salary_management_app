require 'rails_helper'

RSpec.describe EmployeesHelper, type: :helper do
  describe '#displayable_name' do
    let(:employee) { create :employee, first_name: 'Bat', last_name: 'Man'}

    it 'concats first_name and last_name' do
      expect(helper.displayable_name(employee)).to eq("Bat Man")
    end
  end

  describe '#displayable_address' do
    let(:address) { create :address, line_1: 'Line 1', line_2: 'Line 2', city: 'City', state: :andhra_pradesh, country: :india }

    it 'concats all details of address' do
      expect(helper.displayable_address(address.employee)).to eq("Line 1 Line 2 City Andhra pradesh, India")
    end
  end
end
