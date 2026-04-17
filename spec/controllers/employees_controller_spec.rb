require "rails_helper"

RSpec.describe EmployeesController, type: :controller do
  describe '#new' do
    let(:make_request) { get :new }

    it 'renders new' do
      make_request

      expect(response).to render_template(:new)
    end

    it 'returns 200 status on success' do
      make_request

      expect(response).to have_http_status :ok
    end
  end

  describe '#index' do
    let(:make_request) { get :index }

    it 'renders index' do
      make_request

      expect(response).to render_template(:index)
    end

    it 'returns 200 status on success' do
      make_request

      expect(response).to have_http_status :ok
    end
  end
end