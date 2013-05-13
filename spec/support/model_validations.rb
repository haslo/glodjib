shared_examples_for "a model that accepts text" do |property|
  let(:text_input) { "some text" }

  it "accepts text input for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.errors[:"#{property}"].should have(0).errors
  end

  it "returns the value that was set for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.send(:"#{property}").should == text_input
  end
end

shared_examples_for "a model that accepts a boolean" do |property|
  let(:boolean_input) { true }

  it "accepts text input for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", boolean_input)
    record.errors[:"#{property}"].should have(0).errors
  end

  it "returns the value that was set for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", boolean_input)
    record.send(:"#{property}").should == boolean_input
  end
end

shared_examples_for "a model that accepts html with links and formatting" do |property|
  let(:text_input) { "some <strong>bold</strong> text <a href=\"\">with link</a>" }

  it "accepts html input for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.errors[:"#{property}"].should have(0).errors
  end

  it "returns the value that was set for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.send(:"#{property}").should == text_input
  end
end
