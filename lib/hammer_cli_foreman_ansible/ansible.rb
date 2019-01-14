module HammerCLIForemanAnsible
  class AnsibleCommand < HammerCLI::AbstractCommand

    lazy_subcommand(
      'roles',
      _('Manage ansible roles'),
      'HammerCLIForemanAnsible::AnsibleRolesCommand',
      'hammer_cli_foreman_ansible/ansible_roles'
    )

    lazy_subcommand(
      'variables',
      _('Manage ansible variables'),
      'HammerCLIForemanAnsible::AnsibleVariablesCommand',
      'hammer_cli_foreman_ansible/ansible_variables'
    )

    autoload_subcommands
  end
end
