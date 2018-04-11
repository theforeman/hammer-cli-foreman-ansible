module HammerCLIForemanAnsible
  require 'hammer_cli_foreman'
  require 'hammer_cli_foreman/host'
  require 'hammer_cli_foreman/hostgroup'

  require 'hammer_cli_foreman_ansible/version'
  require 'hammer_cli_foreman_ansible/i18n'
  require 'hammer_cli_foreman_ansible/ansible'
  require 'hammer_cli_foreman_ansible/base'
  require 'hammer_cli_foreman_ansible/ansible_roles'
  require 'hammer_cli_foreman_ansible/host'
  require 'hammer_cli_foreman_ansible/hostgroup'

  HammerCLI::MainCommand.lazy_subcommand(
    'ansible',
    'Manage foreman ansible',
    'HammerCLIForemanAnsible::AnsibleCommand',
    'hammer_cli_foreman_ansible/ansible'
  )
  HammerCLIForeman::Host.lazy_subcommand(
    HostAnsibleRolesCommand.command_name,
    HostAnsibleRolesCommand.desc,
    'HammerCLIForemanAnsible::HostAnsibleRolesCommand',
    'hammer_cli_foreman_ansible/host'
  )
  HammerCLIForeman::Hostgroup.lazy_subcommand(
    HostgroupAnsibleRolesCommand.command_name,
    HostgroupAnsibleRolesCommand.desc,
    'HammerCLIForemanAnsible::HostgroupAnsibleRolesCommand',
    'hammer_cli_foreman_ansible/hostgroup'
  )
end
