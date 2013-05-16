# adapted from The RSpec Book, page 235f

module ControllerMacros
  def should_render(template)
    it "returns a HTTP success" do
      do_request
      response.should be_success
    end

    it "renders the #{template} template" do
      do_request
      response.should render_template(template)
    end
  end

  def should_assign(hash)
    variable_name = hash.keys.first
    model, method = hash[variable_name]
    model_access_method = [model, method].join('.')
    it "assigns @#{variable_name} => #{model_access_method}" do
      expected = "the value returned by #{model_access_method}"
      model.should_receive(method).and_return(expected)
      do_request
      assigns[variable_name].should == expected
    end
  end

  def get(action, params = {})
    define_method :do_request do
      get action, params
    end
    yield
  end
end

RSpec.configure do |config|
  config.extend(ControllerMacros, :type => :controller)
end