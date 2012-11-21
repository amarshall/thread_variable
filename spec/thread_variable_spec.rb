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
    klass.my_var.should be_nil
  end

  it "can set and retrieve a thread variable" do
    klass_var = klass.my_var = double
    klass.my_var.should == klass_var
  end

  it "is local to a thread" do
    klass_var = klass.my_var = double
    Thread.new do
      klass.my_var.should be_nil
    end.join
    klass.my_var.should == klass_var
  end

  it "namespaces thread variables for anonymous classes" do
    other_klass = Class.new do
      extend ThreadVariable
      thread_variable :my_var
    end

    klass_var = klass.my_var = double
    other_var = other_klass.my_var = double

    klass.my_var.should == klass_var
    other_klass.my_var.should == other_var
  end

  it "namespaces thread variables for named classes" do
    stub_const 'C', klass
    stub_const 'D', (Class.new do
      extend ThreadVariable
      thread_variable :my_var
    end)

    c_var = C.my_var = double
    d_var = D.my_var = double

    C.my_var.should == c_var
    D.my_var.should == d_var
  end
end
