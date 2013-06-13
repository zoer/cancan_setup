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
      roles.flatten.map(&:to_sym).any? {|r| user.roles.include? r}
    end

    # Rules for guest user
    def guest(&block)
      self.instance_eval &block if user.new_record?
    end

    # Rules for authenticated user
    def authenticated(&block)
      self.instance_eval &block unless user.new_record?
    end
  end
end