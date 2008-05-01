require File.dirname(__FILE__) + '/spec_helper'

module RoutingExample
  nsurl 'http://strokedb.com/zoid/spec#routing'
  remove_const(:SomeName) if defined?(SomeName)
  SomeName = StrokeDB::Meta.new
  SomeView = StrokeDB::View.create!("SomeView") do |view|
    def view.map(key,val)
    end
  end
end


describe Zoid::Application, "router" do
  
  before(:each) do
    @app = Zoid::Application.create!(:name => 'Routing Application', :nsurl => RoutingExample.nsurl)
  end
  
  # GET
  it "should route GET + /name(/)? to a meta document within application module" do
    @app.route_for('GET', '/some_name').should == RoutingExample::SomeName.document
    @app.route_for('GET', '/some_name/').should == RoutingExample::SomeName.document
  end

  it "should route GET + /name(/)? to a view document within application module" do
    @app.route_for('GET', '/some_view').should == RoutingExample::SomeView
    @app.route_for('GET', '/some_view/').should == RoutingExample::SomeView
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