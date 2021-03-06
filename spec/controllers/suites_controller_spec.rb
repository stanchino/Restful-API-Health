require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SuitesController do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Suite. As you add validations to Suite, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:suite) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuitesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:valid_request) { {} }

  before do
    @project = subject.current_user.projects.create(FactoryGirl.attributes_for(:project))
    valid_request.merge!({:project_id => @project.to_param})
  end

  describe "GET index" do
    it "assigns all project suites as @suites" do
      suite = @project.suites.create! valid_attributes
      get :index, valid_request, valid_session
      assigns(:project).should eq(@project)
      assigns(:suites).should eq([suite])
    end

    it "assigns all user suites as @suites" do
      suite = subject.current_user.suites.create! valid_attributes.merge(:project => @project)
      get :index, {}, valid_session
      assigns(:suites).should eq([suite])
    end
  end

  describe "GET show" do
    it "return forbidden if the project id is missing" do
      get :new, {}, valid_session
      response.should be_forbidden
    end

    it "assigns the requested suite as @suite" do
      suite = @project.suites.create! valid_attributes
      get :show, valid_request.merge({:id => suite.to_param}), valid_session
      assigns(:suite).should eq(suite)
    end
    it "assigns the project and the suite" do
      suite = @project.suites.create! valid_attributes
      get :show, valid_request.merge({:id => suite.to_param}), valid_session
      assigns(:suite).should eq(suite)
      assigns(:project).should eq(@project)
    end
  end

  describe "GET new" do
    it "return forbidden if the project id is missing" do
      get :new, {}, valid_session
      response.should be_forbidden
    end

    it "assigns a new suite as @suite" do
      get :new, valid_request, valid_session
      assigns(:project).should eq(@project)
      assigns(:suite).should be_a_new(Suite)
    end
  end

  describe "GET edit" do
    it "return forbidden if the project id is missing" do
      suite = @project.suites.create! valid_attributes
      get :edit, {:id => suite.to_param}, valid_session
      response.should be_forbidden
    end

    it "assigns the requested suite as @suite" do
      suite = @project.suites.create! valid_attributes
      get :edit, valid_request.merge({:id => suite.to_param}), valid_session
      assigns(:suite).should eq(suite)
    end
  end

  describe "POST create" do
    it "return forbidden if the project id is missing" do
      post :create, {}, valid_session
      response.should be_forbidden
    end

    describe "with valid params" do
      it "creates a new Suite" do
        expect {
          post :create, valid_request.merge({:suite => valid_attributes}), valid_session
        }.to change(Suite, :count).by(1)
      end

      it "assigns a newly created suite as @suite" do
        post :create, valid_request.merge({:suite => valid_attributes}), valid_session
        assigns(:suite).should be_a(Suite)
        assigns(:suite).should be_persisted
      end

      it "redirects to the created suite" do
        post :create, valid_request.merge({:suite => valid_attributes}), valid_session
        response.should redirect_to(@project)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved suite as @suite" do
        # Trigger the behavior that occurs when invalid params are submitted
        Suite.any_instance.stub(:save).and_return(false)
        post :create, valid_request.merge({:suite => { "title" => "invalid value" }}), valid_session
        assigns(:suite).should be_a_new(Suite)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Suite.any_instance.stub(:save).and_return(false)
        post :create, valid_request.merge({:suite => { "title" => "invalid value" }}), valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      @suite = @project.suites.create! valid_attributes
      valid_request.merge!({:id => @suite.to_param})
    end
    it "return forbidden if the project id is missing" do
      put :update, {:id => @suite.to_param}, valid_session
      response.should be_forbidden
    end

    describe "with valid params" do
      it "updates the requested suite" do
        # Assuming there are no other suites in the database, this
        # specifies that the Suite created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Suite.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, valid_request.merge({:suite => { "title" => "MyString" }}), valid_session
      end

      it "assigns the requested suite as @suite" do
        put :update, valid_request.merge({:suite => valid_attributes}), valid_session
        assigns(:suite).should eq(@suite)
      end

      it "redirects to the suite" do
        put :update, valid_request.merge({:suite => valid_attributes}), valid_session
        response.should redirect_to(@project)
      end
    end

    describe "with invalid params" do
      it "assigns the suite as @suite" do
        # Trigger the behavior that occurs when invalid params are submitted
        Suite.any_instance.stub(:save).and_return(false)
        put :update, valid_request.merge({:suite => { "title" => "invalid value" }}), valid_session
        assigns(:suite).should eq(@suite)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Suite.any_instance.stub(:save).and_return(false)
        put :update, valid_request.merge({:suite => { "title" => "invalid value" }}), valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @suite = @project.suites.create! valid_attributes
      valid_request.merge!({:id => @suite.to_param})
    end
    it "return forbidden if the project id is missing" do
      delete :destroy, {:id => @suite.to_param}, valid_session
      response.should be_forbidden
    end

    it "destroys the requested suite" do
      expect {
        delete :destroy, valid_request, valid_session
      }.to change(Suite, :count).by(-1)
    end

    it "redirects to the suites list" do
      delete :destroy, valid_request, valid_session
      response.should redirect_to(@project)
    end
  end

end
