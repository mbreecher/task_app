require 'spec_helper'

describe Task do
  before do 
    @task = Task.new(csm_id: "1", customer_id: "1", name: "Example Task", instructions: "do this...", due_date: "2013-12-31")
  end

  subject {@task}

  it { should respond_to(:name)}
  it { should respond_to(:instructions)}
  it { should respond_to(:customer_id)}
  it { should respond_to(:csm_id)}

  it{should be_valid}

  describe "when name not present" do
  	before { @task.name = " "}
  	it { should_not be_valid }
  end
  describe"when name is too long" do
    before { @task.name = "a"*51}
    it {should_not be_valid}
  end

  #test that User(csm_id) should be valid

end
