require 'dm-core'
require 'active_support/core_ext/class/inheritable_attributes'
require 'active_support/core_ext/class/attribute_accessors'
require 'facets/memoize'

Dir[File.join(File.dirname(__FILE__), 'dm-perspectives', '*.rb')].each{|f| require f }

module DataMapper
  module Perspectives

    class NonExistentPerspective < StandardError; end

    module ClassMethods

      # A list of perspectives available to this class
      def perspectives
        perspective_class ?  perspective_class.perspectives.keys : []
      end

      # Add a new perspective for this this class. If the perspective does not
      # exist, it will be created
      def perspective(name,opts={},&blk)
        ( perspective_class ? perspective_class : ::Object.full_const_set(perspective_class_name, Class.new(Base) ) ).perspective(name,opts,&blk)
      end

      # Get around Rails lazy-loading
      def perspective_class
        @_perspective_class ||= ::Object.full_const_get(perspective_class_name) 
      rescue NameError
        nil
      end

      # Set the Perspective Class Name
      # The default perspective class is "#{ModelName}Perspectives".  
      # If you had a model: Post, the Perspective Class would be named
      # PostPerspectives.
      def perspective_class_name=( name )
        @_perspective_class_name = name
      end

      def perspective_class_name
        @_perspective_class_name ||= "#{self}Perspectives"  
      end

    end # ClassMethods
    
    module InstanceMethods

      # Returns the given perspective for an instance
      def perspective(name,opts={})
        raise NonExistentPerspective, "#{self.class} has no perspectives"  unless p = self.class.perspective_class
        p.get_perspective(name,self,opts)
      end

      memoize :perspective

      # Scope calls to the perspective
      def with_perspective(name,opts={},&blk)
        perspective(name,opts).instance_eval(&blk)
      end

    end # InstanceMethods

  end # Perspectives
end # DataMapper

DataMapper::Model.append_extensions DataMapper::Perspectives::ClassMethods
DataMapper::Model.append_inclusions DataMapper::Perspectives::InstanceMethods
