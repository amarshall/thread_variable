require 'thread_variable/version'

module ThreadVariable
  private

  def thread_variable *names
    names.each do |name|
      namespace = (self.name || self.object_id.to_s).to_sym

      define_singleton_method :"#{name}" do
        (Thread.current[namespace] ||= {})[name]
      end

      define_singleton_method :"#{name}=" do |val|
        (Thread.current[namespace] ||= {})[name] = val
      end
    end
  end
end
