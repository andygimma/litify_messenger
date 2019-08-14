require 'rails_helper'

RSpec.describe EmailsController do
  describe "GET index" do
    it "assigns @teams" do
      sign_in
      email = FactoryBot.create(:email)
      get :index
      expect(assigns(:emails)).to eq([email])
    end

    it "renders the index template" do
      sign_in
      get :index
      expect(response).to render_template("index")
    end
  end
end
