require 'thread_variable'

class Class
  include ThreadVariable
end

class Module
  include ThreadVariable
end
