module DataMapper
  module Perspectives
    class Base
      require 'set'

      class_inheritable_hash :perspectives
      self.perspectives = {}

      class << self
        attr_accessor :included_methods

        def get_perspective(name,resource,opts={})
          raise NonExistentPerspective, "Perspective '#{name}' does not exist on #{resource}" unless p = perspectives[name]
          p.new(resource,opts)
        end

        # ==== Options
        # :+include+
        #   If :properties, will include DM properties
        #   If an array, will include the given methods
        # :+exclude+
        #   Excludes the given methods from being added 
        def perspective(name,opts={},&blk) 
          klass = Class.new(self) 
          klass.included_methods = add_methods(opts)
          klass.class_eval &blk
          klass.class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def self.to_s
              "#{self}[#{name}]"
            end
          RUBY
          perspectives[name] = klass
        end

        def model
          ::Object.full_const_get(self.to_s.gsub(/Perspectives(\[[^\]]+\])?$/,''))
        end

        protected

        # Think this should replace, not merge
        def add_methods(opts = {})
          retval = Set.new
          if (inclusions = [*opts[:include]]).any?
            meths = inclusions.inject([]) { |m, i| i == :properties ? m + model.properties.map(&:name) : m << i } - [*opts[:exclude]].compact 
            retval.merge meths
          end
          retval
        end

      end # class << self

      def initialize(resource, opts={})
        @resource = resource
      end

      protected

      # method_missing is faster than copying methods from the original object
      def method_missing(name, *args, &block)
        self.class.included_methods.include?(name) ?  @resource.send(name, *args, &block) : super
      end

    end # Base
  end # Perspectives
end # DataMapper
