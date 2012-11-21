require 'thread_variable/version'

module ThreadVariable
  def thread_variable *names
    names.each do |name|
      define_singleton_method :"#{name}" do
        namespace = (self.name ? self.name : self.object_id.to_s).to_sym
        (Thread.current[namespace] ||= {})[name]
      end

      define_singleton_method :"#{name}=" do |val|
        namespace = (self.name ? self.name : self.object_id.to_s).to_sym
        (Thread.current[namespace] ||= {})[name] = val
      end
    end
  end
end
