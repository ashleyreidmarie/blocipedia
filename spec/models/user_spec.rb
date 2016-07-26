require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  
  #Shoulda tests for username
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_least(2) }
  it { is_expected.to validate_length_of(:username).is_at_most(35) }
  it { should validate_uniqueness_of(:username) }
  
  #Should tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value("user@mudonymous.com").for(:email) }
  
  #Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(username: user.username, email: user.email)
    end
    
    it "should only capitalizes the first letter in username" do
       user.username = "testuser"
       user.save
       expect(user.username).to eq "Testuser"
    end
    
    it "responds to role" do
      expect(user).to respond_to(:role)
    end

     it "responds to admin?" do
       expect(user).to respond_to(:admin?)
     end
    
     it "responds to standard?" do
       expect(user).to respond_to(:standard?)
     end    

     it "responds to premium?" do
       expect(user).to respond_to(:premium?)
     end
     
     describe "roles" do
      it "is standard by default" do
       expect(user.role).to eq("standard")
      end
      
      context "standard user" do
       it "returns true for #standard?" do
         expect(user.standard?).to be_truthy
       end
       
       it "returns false for #premium?" do
         expect(user.premium?).to be_falsey
       end   
       
       it "returns false for #admin?" do
         expect(user.admin?).to be_falsey
       end
      end
      
      context "premium user" do
        before {user.premium!}
        
        it "returns true for #premium?" do
         expect(user.premium?).to be_truthy
        end
        
        it "returns false for #standard?" do
         expect(user.standard?).to be_falsey
        end
        
        it "returns false for #admin?" do
         expect(user.admin?).to be_falsey
        end        
      end
       
      context "admin user" do
        before {user.admin!}
        
        it "returns true for #admin?" do
         expect(user.admin?).to be_truthy
        end
        
        it "returns false for #standard?" do
         expect(user.standard?).to be_falsey
        end
        
        it "returns false for #premium?" do
         expect(user.premium?).to be_falsey
        end        
      end
      
     end
    
  end
  
  describe 'validations' do
    describe 'username' do
      it "cannot contain an @" do
        user.username = "asdf@asdf"
        expect(user).to_not be_valid
      end
      
      it "is valid with a valid username" do
        user.username = "asdfadsfasdf"
        expect(user).to be_valid
      end
    end
  end
  
end
