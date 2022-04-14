# frozen_string_literal: true

module HammerCLIForemanAnsible
  class Hostgroup < HammerCLIForeman::Command
    resource :hostgroups

    class AnsibleRolesCommand < HammerCLIForeman::Command
      command_name 'ansible-roles'
      desc _('Manage Ansible roles on a hostgroup')

      class ListCommand < HammerCLIForeman::ListCommand
        action :ansible_roles

        output(HammerCLIForemanAnsible::AnsibleRolesCommand::ListCommand.output_definition) do
          field :inherited, _('Inherited'), Fields::Boolean
          field :owned, _('Owned'), Fields::Boolean
        end

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

      class AddAnsibleRoleCommand < HammerCLIForeman::AddAssociatedCommand
        prepend HammerCLIForemanAnsible::AssociatedAnsibleRole

        command_name 'add'
        associated_resource :ansible_roles
        desc _('Associate an Ansible role')

        option '--force', :flag, _('Associate the Ansible role even if it already is associated indirectly')

        success_message _('Ansible role has been associated.')
        failure_message _('Could not associate the Ansible role')

        validate_options do
          any(:option_name, :option_title, :option_id).required
          any(:option_ansible_role_name, :option_ansible_role_id).required
        end

        build_options
      end

      class RemoveAnsibleRoleCommand < HammerCLIForeman::RemoveAssociatedCommand
        prepend HammerCLIForemanAnsible::AssociatedAnsibleRole

        command_name 'remove'
        associated_resource :ansible_roles
        desc _('Disassociate an Ansible role')

        success_message _('Ansible role has been disassociated.')
        failure_message _('Could not disassociate the Ansible role')

        validate_options do
          any(:option_name, :option_title, :option_id).required
          any(:option_ansible_role_name, :option_ansible_role_id).required
        end

        build_options
      end

      autoload_subcommands
    end
  end
end
