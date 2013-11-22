require 'spec_helper'

describe Task do
  before do 
    @task = Task.new(name: "Example Task", instructions: "do this...", reference: "1/1/2012", offset: "-12", csm_id: "3")
  end

  subject {@task}

  it { should respond_to(:name)}
  it { should respond_to(:instructions)}
  it { should respond_to(:reference)}
  it { should respond_to(:offset)}
  it { should respond_to(:csm_id)}

  it{should be_valid}

  describe "when name not present" do
  	before { @task.name = " "}
  	it { should_not be_valid }
  end
  describe "when name not present" do
  	before { @task.reference = " "}
  	it { should_not be_valid }
  end
  describe"when name is too long" do
    before { @task.name = "a"*51}
    it {should_not be_valid}
  end

  #test that User(csm_id) should be valid

end
