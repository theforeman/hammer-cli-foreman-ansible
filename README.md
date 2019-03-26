# Hammer CLI Foreman Ansible

This Hammer CLI plugin contains set of commands for [foreman_ansible](
  https://github.com/theforeman/foreman_ansible
), a plugin to Foreman for Ansible.

## Versions

This is the list of which version of Foreman Ansible is needed to which version of this plugin.

| hammer_cli_foreman_ansible | 0.1.0+ |
|----------------------------|--------|
|            foreman_ansible | 2.2.0+ |

## Installation

    $ gem install hammer_cli_foreman_ansible

    $ mkdir -p ~/.hammer/cli.modules.d/

    $ cat <<EOQ > ~/.hammer/cli.modules.d/foreman_ansible.yml
    :foreman_ansible:
      :enable_module: true
    EOQ

    # to confirm things work, this should return useful output
    hammer ansible --help

## More info

See our [Hammer CLI installation and configuration instuctions](
https://github.com/theforeman/hammer-cli/blob/master/doc/installation.md#installation).
