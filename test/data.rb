class Basic
  include DataMapper::Resource
  property :id, Serial
end

class Foo
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :age, Integer

  def initialize(name = "foo", age = 10)
    @name = name
    @age  = age
  end

  def name_all_caps
    name.upcase
  end

  def age_times_100
    age*100
  end

  perspective :foo,:include => [:age_times_100,:name_all_caps] do
    def age_in_dog_years
      @resource.age*7
    end

    def onerific_title
      "#{@resource.name}-sama"
    end
  end

end

class Bar
  include DataMapper::Resource
  property :id, Serial
  property :name, Integer
  property :age, Integer

  def initialize(name = "bar", age = 10)
    @name = name
    @age  = age
  end
end

module BarModule
  def module_method
    "module_method"
  end
end

class BarPerspectives < DataMapper::Perspectives::Base

  perspective :bar, :include => :properties, :exclude => [:age] do
    include BarModule
    def age_in_dog_years
      @resource.age*7
    end

    def onerific_title
      "#{@resource.name}-sama"
    end
  end

end

class Baz
  include DataMapper::Resource
  property :id, Serial
  property :name, Integer
  property :age, Integer

  def initialize(name = "baz", age = 10)
    @name = name; @age  = age
  end
end

class Quux < Baz 
  def initialize(name = "quux", age = 10)
    @name = name; @age  = age
  end
end

class BasePerspectives < DataMapper::Perspectives::Base
  def self.foo
    'class foo'
  end

  def foo
    'instance foo'
  end
  perspective :baz, :include => [:name,:age], :exclude => [:age] do
    def age_in_dog_years
      @resource.age*7
    end

    def onerific_title
      "#{@resource.name}-sama"
    end
  end
end

class BazPerspectives < BasePerspectives
end

class QuuxPerspectives < BasePerspectives

  def self.foo
    'class quux foo'
  end

  def foo
    'instance quux foo'
  end

  def self.set_ivar
    @ivar = "SET"
  end

  perspective :baz, :include => [] do
    set_ivar
    def age_in_dog_years
      9000
    end
  end
end

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate! if defined?(DataMapper)
