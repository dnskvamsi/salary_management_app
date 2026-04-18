require 'rails_helper'

RSpec.describe EmployeesHelper, type: :helper do
  describe '#displayable_name' do
    let(:employee) { create :employee, first_name: 'Bat', last_name: 'Man'}

    it 'concats first_name and last_name' do
      expect(helper.displayable_name(employee)).to eq("Bat Man")
    end
  end
end
