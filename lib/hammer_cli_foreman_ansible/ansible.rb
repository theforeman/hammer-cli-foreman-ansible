module HammerCLIForemanAnsible
  class AnsibleCommand < HammerCLIForeman::Command
    resource :ansible

    lazy_subcommand(
      'roles',
      _('Manage ansible roles'),
      'HammerCLIForemanAnsible::AnsibleRolesCommand',
      'hammer_cli_foreman_ansible/ansible_roles'
    )

    autoload_subcommands
  end
end
