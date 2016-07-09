module ControllerMacros
  def login_user(user = FactoryGirl.create(:user))
    # before(:each) do
      sign_in user
    # end
  end
end
