require File.dirname(__FILE__) + '/spec_helper'

module RoutingExample
  nsurl 'http://strokedb.com/zoid/spec#routing'
  remove_const(:SomeName) if defined?(SomeName)
  SomeName = StrokeDB::Meta.new
end


describe Zoid::Application, "router" do
  
  before(:each) do
    setup_default_store
    @app = Zoid::Application.create!(:name => 'Routing Application', :nsurl => RoutingExample.nsurl)
  end
  
  # GET
  it "should route GET + /name(/)? to a named entity within application module" do
    @app.route_for('GET', '/some_name').should == RoutingExample::SomeName
    @app.route_for('GET', '/some_name/').should ==RoutingExample::SomeName
  end

  it "should route GET + /name/uuid to a named entity with specified UUID" do
    doc = RoutingExample::SomeName.create!
    @app.route_for('GET', "/some_name/#{doc.uuid}").should == doc
  end

  it "should route GET + /name/uuid.version to a named entity with specified UUID" do
    doc = RoutingExample::SomeName.create!.versions.current
    @app.route_for('GET', "/some_name/#{doc.uuid}.#{doc.version}").should == doc
  end
  
end