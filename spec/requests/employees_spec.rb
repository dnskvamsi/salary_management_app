require 'rails_helper'

RSpec.describe 'routes for employees', type: :routing do
  it { expect(get('/employees/new')).to route_to('employees#new') }
end