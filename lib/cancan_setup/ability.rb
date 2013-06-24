module CanCanSetup
  module Ability
    def initialize(user, *options)
      @user = user
      if options.kind_of? Hash
        @params = options[:params] if options[:params].present?
      end
      load_configs
    end

    # Current user
    def user
      @user ||= Users::User.new
    end

    def params
      @params ||= {}
    end

    def load_configs
      CanCanSetup.configs.each do |block|
        self.instance_eval &block
      end
    end

    def role(*roles, &block)
      self.instance_eval &block if has_any_role(roles)
    end

    def has_any_role(*roles)
      roles.flatten.map(&:to_sym).any? {|r| user_roles.include? r}
    end

    def user_roles
      get_inherited_roles(user.roles.map{ |v| v.to_sym })
    end

    # Rules for guest user
    def guest(&block)
      self.instance_eval &block if user.new_record?
    end

    # Rules for authenticated user
    def authenticated(&block)
      self.instance_eval &block unless user.new_record?
    end

    private

    # Get inherited roles for user
    def get_inherited_roles(roles)
      roles = Set.new roles
      begin
      end while roles_recursion(roles)
      roles
    end

    # Roles recursion matching
    def roles_recursion(roles)
      has_matches = false
      CanCanSetup.delegated_roles.each_pair do |key, values|
        if !values.nil? and roles.include?(key)
          values.each do |val|
            unless roles.include? val
              has_matches = true
              roles << val
            end
          end
        end
      end
      has_matches
    end

  end
end