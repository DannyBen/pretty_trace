require 'fileutils'

class SomeClass
  def initialize
    build_something
  end
  
  def build_something
    remove_directory
  end

  def remove_directory
    FileUtils.rm 'no/such/dir'
  end
end
