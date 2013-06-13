require "cancan_setup/setup_helper"
require "cancan_setup/ability"

module CanCanSetup
  @@configs = []
  mattr_accessor :configs

  def self.setup(&block)
    setup_helper = SetupHelper.new
    setup_helper.instance_eval { self.instance_eval &block }
  end
end
