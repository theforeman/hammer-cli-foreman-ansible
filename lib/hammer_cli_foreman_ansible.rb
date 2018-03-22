require 'hammer_cli_foreman'

module HammerCLIForemanAnsible
  require 'hammer_cli_foreman_ansible/version'
  require 'hammer_cli_foreman_ansible/i18n'
  require 'hammer_cli_foreman_ansible/ansible'
  require 'hammer_cli_foreman_ansible/ansible_roles'

  HammerCLI::MainCommand.lazy_subcommand(
    'ansible',
    'Manage foreman ansible',
    'HammerCLIForemanAnsible::AnsibleCommand',
    'hammer_cli_foreman_ansible/ansible'
  )
end
