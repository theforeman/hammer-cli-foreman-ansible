# Hammer CLI Foreman Ansible

[Foreman Ansible](https://github.com/theforeman/foreman_ansible) plugin for Hammer CLI

## Installation

    $ gem install hammer_cli_foreman_ansible

    $ mkdir -p ~/.hammer/cli.modules.d/

    $ cat <<EOQ > ~/.hammer/cli.modules.d/foreman_ansible.yml
    :foreman_ansible:
      :enable_module: true
    EOQ

    # to confirm things work, this should return useful output
    hammer ansible --help
