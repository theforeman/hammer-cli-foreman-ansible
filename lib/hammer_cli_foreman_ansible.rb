module HammerCLIForemanAnsible
  require 'hammer_cli'
  require 'hammer_cli_foreman'
  require 'hammer_cli_foreman/host'
  require 'hammer_cli_foreman/hostgroup'

  require 'hammer_cli_foreman_ansible/version'
  require 'hammer_cli_foreman_ansible/i18n'
  require 'hammer_cli_foreman_ansible/ansible'
  require 'hammer_cli_foreman_ansible/ansible_roles'
  require 'hammer_cli_foreman_ansible/associated_ansible_role'
  require 'hammer_cli_foreman_ansible/host'
  require 'hammer_cli_foreman_ansible/hostgroup'

  require 'hammer_cli_foreman_ansible/command_extensions'

  HammerCLI::MainCommand.lazy_subcommand(
    'ansible',
    'Manage foreman ansible',
    'HammerCLIForemanAnsible::AnsibleCommand',
    'hammer_cli_foreman_ansible/ansible'
  )
  HammerCLIForeman::Host.lazy_subcommand(
    Host::AnsibleRolesCommand.command_name,
    Host::AnsibleRolesCommand.desc,
    'HammerCLIForemanAnsible::Host::AnsibleRolesCommand',
    'hammer_cli_foreman_ansible/host'
  )
  HammerCLIForeman::Hostgroup.lazy_subcommand(
    Hostgroup::AnsibleRolesCommand.command_name,
    Hostgroup::AnsibleRolesCommand.desc,
    'HammerCLIForemanAnsible::Hostgroup::AnsibleRolesCommand',
    'hammer_cli_foreman_ansible/hostgroup'
  )
end
