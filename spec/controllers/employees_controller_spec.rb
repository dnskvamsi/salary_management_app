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

  describe '#stats' do
    let(:make_request) { get :stats }

    it 'renders new' do
      make_request

      expect(response).to render_template(:stats)
    end

    it 'returns 200 status on success' do
      make_request

      expect(response).to have_http_status :ok
    end
  end

  describe "#create" do
    context "success" do
      let(:params) do
        {
          employee: attributes_for(:employee).merge(
            address_attributes: attributes_for(:address)
          )
        }
      end

      it "redirects and shows notice" do
        post :create, params: params
  
        expect(response).to redirect_to(employees_path)
        expect(flash[:notice]).to be_present
      end
    end

    context "failure" do
      it "renders the new template" do
        post :create, params: { employee: { first_name: nil } }
  
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "#edit" do
    let(:employee) { create :employee }
  
    context "when employee already has an address" do
      let!(:address) { create(:address, employee: employee) }

      it "assigns the requested employee to @employee" do
        get :edit, params: { id: employee.id }

        expect(assigns(:employee)).to eq(employee)
      end

      it "uses the existing address" do
        get :edit, params: { id: employee.id }

        expect(assigns(:employee).address).to eq(address)
        expect(assigns(:employee).address).to be_persisted
      end

      it "renders the edit template" do
        get :edit, params: { id: employee.id }

        expect(response).to render_template(:edit)
      end
    end

    context "when employee does not have an address" do
      it "builds a new address for the employee" do
        get :edit, params: { id: employee.id }
        
        expect(assigns(:employee).address).to be_a_new(Address)
      end
    end

    it "renders the new template" do
      get :edit, params: { id: employee.id }

      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let!(:employee) { create(:employee, first_name: "Original") }
    
    context "with valid parameters" do
      let(:new_attributes) { { first_name: "Updated" } }
      let(:make_request) { patch :update, params: { id: employee.id, employee: new_attributes } }

      it "updates the requested employee" do
        make_request
        
        expect(employee.reload.first_name).to eq("Updated")
      end

      it "redirects to the employees index" do
        make_request
    
        expect(response).to redirect_to(employees_path)
      end

      it "sets a flash notice" do
        make_request

        expect(flash[:notice]).to eq("Employee updated successfully.")
      end
    end

    context "with invalid parameters" do
      it "does not update the employee" do
        patch :update, params: { id: employee.id, employee: { first_name: "" } }
        
        expect(employee.reload.first_name).to eq("Original")
      end

      it "renders the edit template with unprocessable_entity status" do
        patch :update, params: { id: employee.id, employee: { first_name: "" } }
        
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "#destroy" do
    let!(:employee) { create :employee }
    let(:make_request) { delete :destroy, params: { id: employee.id } }

    it "destroys the requested employee" do
      expect {
        make_request
      }.to change(Employee, :count).by(-1)
    end

    it "redirects to the employees list" do
      make_request
  
      expect(response).to redirect_to(employees_path)
    end

    it "sets a flash notice" do
      make_request

      expect(flash[:notice]).to eq("Employee deleted.")
    end
    
    context "with associated address" do
      let!(:address) { create(:address, employee: employee) }
      
      it "destroys the associated address as well" do
        expect {
          make_request
        }.to change(Address, :count).by(-1)
      end
    end
  end
end