require 'helper'
require 'data'

class TestDmPerspectives < Test::Unit::TestCase

  # Class Methods

  should "#perspectives return an empty array" do
    assert_equal [], Basic.perspectives
  end

  should "allow you to define perspective in the model" do
    assert_equal [:foo], Foo.perspectives
  end
  
  should "allow you to define perspective in a separate class" do
    assert_equal [:bar], Bar.perspectives
  end

  context "working with perspectives" do

    setup do
      @basic = Basic.new
      @foo = Foo.new("bob",10)
      @bar = Bar.new("jim",10)
    end

    # Object Methods
    
    should "raise an error if the perspective does not exist" do
      assert_raise DataMapper::Perspectives::NonExistentPerspective  do
        @basic.perspective(:foo)
      end

      assert_raise DataMapper::Perspectives::NonExistentPerspective  do
        @foo.perspective(:whatever)
      end
    end

    should "allow you to get an object's perspective with inline definition" do
      assert_equal 70,         @foo.perspective(:foo).age_in_dog_years
      assert_equal "bob-sama", @foo.perspective(:foo).onerific_title
    end

    should "allow you to get an object's perspective with separate class" do
      assert_equal 70,         @bar.perspective(:bar).age_in_dog_years
      assert_equal "jim-sama", @bar.perspective(:bar).onerific_title
    end

    should "allow including modules" do
      assert_equal("module_method", @bar.perspective(:bar).module_method)
    end

    should "allow you to use a perspective in a block" do
      age = title = false
      @bar.with_perspective :bar do
        age   = age_in_dog_years
        title = onerific_title
      end
      assert_equal 70,         age
      assert_equal "jim-sama", title
    end

    should "cache the perspective object" do
      b  = @bar
      id = b.perspective(:bar).__id__
      assert_equal id, b.perspective(:bar).__id__
    end
    
    should "allow you to include object properties as methods of the perspective" do
      p = @bar.perspective(:bar)
      assert_equal 70, p.age_in_dog_years
      assert_equal "jim", p.name
    end

    should "allow you to include existing methods" do
      p = @foo.perspective(:foo)
      assert_equal 1000,  p.age_times_100
      assert_equal "BOB", p.name_all_caps
      assert_raise NoMethodError do
        p.name
      end
    end

    should "allow you to exclude methods" do
      p = @bar.perspective(:bar)
      assert_raise NoMethodError do
        p.age
      end
    end

  end

  context "subclassing" do
    setup do
      @baz  = Baz.new.perspective(:baz)
      @quux = Quux.new.perspective(:baz)
    end

    should "allow you to inherit perspectives methods" do
      assert_raise NoMethodError do
        @baz.age
      end
      assert_equal 70,         @baz.age_in_dog_years
      assert_equal "baz",      @baz.name
      assert_equal "baz-sama", @baz.onerific_title
    end

    should "overwrite inclusions" do
      assert_raise NoMethodError do
        @quux.age
      end
      assert_raise NoMethodError do
        @quux.name
      end
    end

    should "overwrite existing methods in the perspective" do
      assert_equal 9000, @quux.age_in_dog_years
    end

  end
  
  # This isn't named right, we're not doing that anymore
  context "method_missing" do
    setup do
      @baz  = Baz.new.perspective(:baz)
      @quux = Quux.new.perspective(:baz)
    end

    should "instance methods to delegate to the Perspectives instance methods" do
      assert_equal 'instance foo',      @baz.foo
      assert_equal 'instance quux foo', @quux.foo
    end

    should "class methods to delegate to the Perspectives class methods" do
      assert_equal 'class foo',       @baz.class.foo
      assert_equal 'class quux foo',  @quux.class.foo
    end

    should "should be a subclass of the parent" do
      assert_equal 'SET',  @quux.class.instance_variable_get(:@ivar)
    end
  end

end
