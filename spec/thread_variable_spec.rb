require 'spec_helper'

describe ThreadVariable do
  let(:klass) do
    Class.new do
      extend ThreadVariable
      thread_variable :my_var
    end
  end

  before do
    # Normally I wouldn't do this, but threads are special
    expect(klass.my_var).to be_nil
  end

  it "can set and retrieve a thread variable" do
    klass_var = klass.my_var = double
    expect(klass.my_var).to eq klass_var
  end

  it "cannot set a thread variable outside the class scope" do
    expect do
      klass.thread_variable :made_publicly
    end.to raise_error NoMethodError, /private method/
  end

  it "is local to a thread" do
    klass_var = klass.my_var = double
    Thread.new do
      expect(klass.my_var).to be_nil
    end.join
    expect(klass.my_var).to eq klass_var
  end

  it "namespaces thread variables for anonymous classes" do
    other_klass = Class.new do
      extend ThreadVariable
      thread_variable :my_var
    end

    klass_var = klass.my_var = double
    other_var = other_klass.my_var = double

    expect(klass.my_var).to eq klass_var
    expect(other_klass.my_var).to eq other_var
  end

  it "namespaces thread variables for named classes" do
    stub_const 'C', klass
    stub_const 'D', (Class.new do
      extend ThreadVariable
      thread_variable :my_var
    end)

    c_var = C.my_var = double
    d_var = D.my_var = double

    expect(C.my_var).to eq c_var
    expect(D.my_var).to eq d_var
  end
end
