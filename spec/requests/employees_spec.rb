require 'rails_helper'

RSpec.describe 'routes for employees', type: :routing do
  it { expect(get('/employees/new')).to route_to('employees#new') }
  it { expect(get('/employees')).to route_to('employees#index') }
  it { expect(delete("/employees/1")).to route_to("employees#destroy", id: "1") }
  it { expect(get("/employees/1/edit")).to route_to("employees#edit", id: "1") }
  it { expect(get('/employees/stats')).to route_to('employees#stats') }
  it { expect(get('/')).to route_to('employees#index') }
  it { expect(post("/employees/")).to route_to("employees#create") }
  it { expect(patch('/employees/1/')).to route_to('employees#update', id: "1" ) }
end