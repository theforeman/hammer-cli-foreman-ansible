# frozen_string_literal: true

module HammerCLIForemanAnsible
  class Hostgroup < HammerCLIForeman::Command
    resource :hostgroups

    class AnsibleRolesCommand < HammerCLIForeman::Command
      command_name 'ansible-roles'
      desc _('Manage Ansible roles on a hostgroup')

      class ListCommand < HammerCLIForeman::ListCommand
        action :ansible_roles

        output HammerCLIForemanAnsible::AnsibleRolesCommand::ListCommand.output_definition

        build_options
      end

      class PlayCommand < HammerCLIForeman::Command
        command_name 'play'
        action :play_roles

        success_message _('Ansible roles are being played. Job ID: %{id}')
        failure_message _('Could not play roles on a hostgroup')

        build_options
      end

      class AssignRolesCommand < HammerCLIForeman::Command
        command_name 'assign'
        action :assign_ansible_roles

        success_message _('Ansible roles were assigned to the hostgroup')
        failure_message _('Could not assign roles to the hostgroup')

        build_options
      end

      autoload_subcommands
    end
  end
end
