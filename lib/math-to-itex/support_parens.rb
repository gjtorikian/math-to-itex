# from http://coderrr.wordpress.com/2008/11/30/overloading-the-parenthesis-operator-in-ruby/

class Object
  alias_method :orig_method_missing, :method_missing

  def method_missing(m, *a, &b)
    klass = begin
      (self.is_a?(Module) ? self : self.class).const_get(m)
    rescue NameError
    end

    return klass.send(:parens, *a, &b)  if klass.respond_to? :parens
    orig_method_missing m, *a, &b
  end
end
