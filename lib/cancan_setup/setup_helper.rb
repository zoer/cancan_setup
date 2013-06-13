module CanCanSetup
  class SetupHelper
    def initialize
    end

    def config(name,&block)
      CanCanSetup.configs.push block
    end
  end
end