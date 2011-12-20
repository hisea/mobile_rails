require "spec_helper"

describe MobileRails::ControllerAdditions::InstanceMethods do
  let(:controller_class) { Class.new }
  let(:controller) { controller_class.new }
  let(:session) { Hash.new }
  let(:request) { Object.new }

  before(:each) do
    controller_class.send(:include, MobileRails::ControllerAdditions::InstanceMethods)
    controller.stub(:session) { session }
    controller.stub(:request) { request }
  end

  describe ".set_mobile_request" do
    it "should not mobile request if having a web version session" do
      request.stub(:user_agent).and_return("iphone")
      session[:mobile_session] = 0
      controller.request.should_not_receive(:format=).with(:mobile)
      controller.set_mobile_request
      session[:mobile_session].should == 0
    end

    it "should set mobile request as default for a mobile devise" do
      request.stub(:user_agent).and_return("iphone")
      controller.request.should_receive(:format=).with(:mobile)
      controller.set_mobile_request
      session[:mobile_session].should == 1
    end

    it "should not set mobile request for a non mobile devise" do
      request.stub(:user_agent).and_return("mozilla")
      controller.request.should_not_receive(:format=).with(:mobile)
      controller.set_mobile_request
    end
  end

  describe ".mobile_session?" do
    it "should return true if session is set to mobile" do
      session[:mobile_session] = 1
      controller.mobile_session?.should be_true
    end
    it "should return false if session is not set to mobile" do
      session[:mobile_session] = 0
      controller.mobile_session?.should be_false
    end
  end

  describe "mobile?" do
    it "should return true for mobile devise" do
      request.stub(:user_agent).and_return("iphone")
      controller.mobile?.should be_true
    end
    it "should return false for non mobile devise" do
      request.stub(:user_agent).and_return("iphone")
      controller.mobile?.should be_true
    end
  end

  describe MobileRails::ControllerAdditions::ClassMethods do
    let(:controller_class) { Class.new }
    let(:controller) { controller_class.new }

    describe "#has_mobile_rails" do
      it "should set up controller" do
        controller_class.send(:extend, MobileRails::ControllerAdditions::ClassMethods)
        controller_class.should_receive(:before_filter).with(:set_mobile_request)
        controller_class.should_receive(:helper_method).with :mobile?
        controller_class.should_receive(:layout).with(:mobile_layout)
        controller_class.should_receive(:include).with(MobileRails::ControllerAdditions::InstanceMethods)
        controller_class.has_mobile_rails
      end
    end
  end

end
