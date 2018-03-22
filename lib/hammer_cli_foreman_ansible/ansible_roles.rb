require 'hammer_cli'
require 'hammer_cli_foreman'

module HammerCLIForemanAnsible
  class AnsibleRolesCommand < HammerCLIForeman::Command
    resource :ansible_roles

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :name, _('Name')
      end

      build_options
    end

    autoload_subcommands
  end
end
