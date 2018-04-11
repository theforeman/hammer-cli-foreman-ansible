module HammerCLIForemanAnsible
  class HostAnsibleRolesCommand < BaseAnsibleRolesCommand
    resource :hosts
    build_options
  end
end
