# frozen_string_literal: true

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

    lazy_subcommand(
      'inventory',
      _('Ansible Inventory'),
      'HammerCLIForemanAnsible::AnsibleInventoryCommand',
      'hammer_cli_foreman_ansible/ansible_inventory'
    )
    autoload_subcommands
  end
end
