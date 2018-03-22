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
