require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Disqussed::Api do
  describe "thread" do
    it "should create the thread" do
      #p Disqussed::Api.post('threads', 'open', { :thread => 1, :api_key => "DwwALtvEas5hYiPZN77Va80fD74tPzxJ8uCj1Iatdon3XkcA7GIbL7Ty7hSbaM0X", :access_token => "671388dfed0144e59ebfe9fe401bb832" })
    end
  end

  describe "post" do
    it "should create the post" do
      lambda {
        #p Disqussed::Api.post('posts', 'create', { :message => "testing", :api_key => "DwwALtvEas5hYiPZN77Va80fD74tPzxJ8uCj1Iatdon3XkcA7GIbL7Ty7hSbaM0X", :thread => 1, :author_email => "s@stippleit.com", :author_name => "Sam Stipple" })
      }.should_not raise_error
    end
  end
end