require File.dirname(__FILE__) + '/spec_helper'

describe Zoid::Application, "router" do
  
  before(:each) do
    setup_default_store
    @module = Module.new do
      nsurl 'http://strokedb.com/zoid/spec#routing'
      SomeName = StrokeDB::Meta.new
    end
    @app = Zoid::Application.create!(:name => 'Routing Application', :nsurl => @module.nsurl)
  end
  
  it "should route GET + /name(/)? to a named entity within application module" do
    @app.route_for('GET', '/some_name').should == @module.const_get('SomeName')
    @app.route_for('GET', '/some_name/').should == @module.const_get('SomeName')
  end
  
end