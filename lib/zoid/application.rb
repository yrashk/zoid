module Zoid
  nsurl "http://strokedb.com/zoid"
  Application = StrokeDB::Meta.new do
    validates_presence_of :name
    validates_presence_of :nsurl
  end
end