require 'rails_helper'

RSpec.describe MudPolicy do
  
  subject { MudPolicy.new(user, mud) }

  # context "for guest users" do
  #   let(:user) { nil }

  #   it { should     permit(:show)    }

  #   it { should_not permit(:create)  }
  #   it { should_not permit(:new)     }
  #   it { should_not permit(:update)  }
  #   it { should_not permit(:edit)    }
  #   it { should_not permit(:destroy) }
  #   it { should_not permit(:dashboard) }
  #   it { should_not permit(:approval) }
  # end

  # context "for standard or premium users" do
  #   let(:user) { FactoryGirl.create(:user) }

  #   it { should permit(:show)    }
  #   it { should permit(:create)  }
  #   it { should permit(:new)     }
  #   it { should_not permit(:update)  }
  #   it { should_not permit(:edit)    }
  #   it { should_not permit(:destroy) }
  #   it { should_not permit(:dashboard) }
  #   it { should_not permit(:approval) }
  # end
  
  # # context "for admin users" do
  # #   before { user.admin! }
    
  # #   it { should permit(:show)    }
  # #   it { should permit(:create)  }
  # #   it { should permit(:new)     }
  # #   it { should permit(:update)  }
  # #   it { should permit(:edit)    }
  # #   it { should permit(:destroy) }
  # #   it { should permit(:dashboard) }
  # #   it { should permit(:approval) }
  # # end  

  describe ".scope" do
    let(:approved_mud) { create(:mud, approved: true) }
    let(:unapproved_mud) { create(:mud, approved: false) }
  
    describe "admin users" do
      let(:user) { create(:user, role: :admin) }
      
      it "returns all muds" do
        muds = MudPolicy::Scope.new(user, Mud).resolve
        expect(muds).to include(approved_mud, unapproved_mud)
      end
      
    end
    
    describe "all other users" do
      let(:user) { create(:user) }
      
      it "returns only approved muds" do
       muds = MudPolicy::Scope.new(user, Mud).resolve
       expect(muds).to_not include(unapproved_mud)
      end
    end
  end

end
