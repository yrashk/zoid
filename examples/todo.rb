#! /usr/bin/env ruby
$:.unshift File.dirname(__FILE__) + "/../lib"
require 'zoid'

StrokeDB::Config.build :default => true, :base_path => 'todo.strokedb'

module Todo
  
  nsurl 'http://strokedb.com/zoid/examples/todo'
  
  Item = StrokeDB::Meta.new do
    def done!
      self.done = true
      save!
    end
  end

  List = StrokeDB::Meta.new do
    has_many :items
  end
  
  APPLICATION = Zoid::Application.find_or_create(:name => "Todo", :nsurl => Todo.nsurl)
  
end

puts "Serving #{Todo::APPLICATION}"

Zoid.run(:mongrel, Todo::APPLICATION)
