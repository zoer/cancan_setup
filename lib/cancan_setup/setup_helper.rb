module CanCanSetup
  class SetupHelper
    def initialize
    end

    def config(name,&block)
      CanCanSetup.configs.push block
    end

    # Delegate role inheritance
    #
    # @example Delegate :moderator role to :super_moderator
    #   delegate_roles [:moderator], to: :super_moderator
    def delegate_roles(*args)
      to = args.last[:to]
      to = to.is_a?(Array) ? to : [to]

      roles = args.first
      roles = roles.is_a?(Array) ? roles : [roles]

      to.each do |key|
        if CanCanSetup.delegated_roles[key].nil?
          CanCanSetup.delegated_roles[key] = roles
        else
          CanCanSetup.delegated_roles[key] += roles
        end
      end
    end
  end
end