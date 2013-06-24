require "cancan_setup/setup_helper"
require "cancan_setup/ability"

module CanCanSetup
  def self.configs
    @@configs ||= []
  end

  def self.delegated_roles
    @@delegated_roles ||= {}
  end

  def self.setup(&block)
    setup_helper = SetupHelper.new
    setup_helper.instance_eval { self.instance_eval &block }
  end
end
