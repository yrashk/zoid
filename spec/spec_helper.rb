$LOAD_PATH.unshift( File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')) ).uniq!
require 'zoid'

SPEC_ROOT = File.expand_path(File.dirname(__FILE__))
TEMP_DIR = SPEC_ROOT + '/tmp'
TEMP_STORAGES = TEMP_DIR + '/storages'

def setup_default_store
  FileUtils.rm_rf TEMP_STORAGES + '/spec'
  StrokeDB::Config.build :default => true, :base_path => TEMP_STORAGES + '/spec'
end

setup_default_store

at_exit do
  FileUtils.rm_rf TEMP_STORAGES + '/spec'
end