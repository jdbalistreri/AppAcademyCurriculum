class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      make_getter(name)
      make_setter(name)
    end
  end

  def self.make_getter(name)
    define_method(name) do
      instance_variable_get("@#{name}")
    end
  end

  def self.make_setter(name)
    define_method("#{name}=") do |value|
      instance_variable_set("@#{name}", value)
    end
  end
end
