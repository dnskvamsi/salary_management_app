require 'rails_helper'

RSpec.describe 'routes for employees', type: :routing do
  it { expect(get('/employees/new')).to route_to('employees#new') }
  it { expect(get('/employees/')).to route_to('employees#index') }
  it { expect(get('/employees/stats')).to route_to('employees#stats') }
  it { expect(get('/')).to route_to('employees#index') }
end