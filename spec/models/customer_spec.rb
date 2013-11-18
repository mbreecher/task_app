require 'spec_helper'

describe Customer do
  before do 
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  	@customer = Customer.new(csm_id: @user.id, name: "Example Company", start: "1/1/2010", fiscal_ye: "12/31/2013", next_per_end: "12/31/2013", next_target: "2/15/2014")
  end

  subject {@customer}

  it { should respond_to(:csm_id)}
  it { should respond_to(:name)}
  it { should respond_to(:start)}
  it { should respond_to(:fiscal_ye)}
  it { should respond_to(:next_per_end)}
  it { should respond_to(:next_target)}

  it{should be_valid}

  describe "when name not present" do
  	before { @customer.name = " "}
  	it { should_not be_valid }
  end
  describe "when name not present" do
  	before { @customer.start = " "}
  	it { should_not be_valid }
  end
  describe"when name is too long" do
    before { @customer.name = "a"*51}
    it {should_not be_valid}
  end

  #test that User(csm_id) should be valid

end
