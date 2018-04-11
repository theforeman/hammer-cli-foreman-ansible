module HammerCLIForemanAnsible
  class HostgroupAnsibleRolesCommand < BaseAnsibleRolesCommand
    resource :hostgroups
    build_options
  end
end
