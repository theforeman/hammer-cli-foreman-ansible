# frozen_string_literal: true

module HammerCLIForemanAnsible
  class AnsibleRolesCommand < HammerCLIForeman::Command
    resource :ansible_roles

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
        field :created_at, _('Imported at'), Fields::Date
      end
      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output AnsibleRolesCommand::ListCommand.output_definition
      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Ansible role [%{name}] was deleted.')
      failure_message _('Could not delete the role')

      build_options
    end

    class SyncCommand < HammerCLIForeman::Command
      action :sync
      command_name 'sync'

      success_message _('A task to Sync Ansible Roles was created.')
      failure_message _('Could not sync roles')
      build_options
    end

    class ImportCommand < HammerCLIForeman::Command
      action :import
      command_name 'import'

      failure_message _('Could not import roles')

      output do
        field :message, _('Result'), Fields::LongText
        collection :changed, _('Imported'), hide_blank: true do
          field :name, nil
        end
      end

      def execute
        response = {}
        response['changed'] = send_request
        response['message'] = _('The following ansible roles were changed')
        if response['changed'].empty?
          response['message'] = _('No changes in ansible roles detected.')
        end
        print_data(response)
        HammerCLI::EX_OK
      end

      build_options
    end

    class ObsoleteCommand < HammerCLIForeman::Command
      action :obsolete
      command_name 'obsolete'

      failure_message _('Could not obsolete roles')

      output do
        field :message, _('Result'), Fields::LongText
        collection :changed, _('Obsoleted'), hide_blank: true do
          field :name, nil
        end
      end

      def execute
        response = {}
        response['changed'] = send_request
        response['message'] = _('The following ansible roles were changed')
        if response['changed'].empty?
          response['message'] = _('No changes in ansible roles detected.')
        end
        print_data(response)
        HammerCLI::EX_OK
      end

      build_options
    end

    class FetchCommand < HammerCLIForeman::Command
      action :fetch
      command_name 'fetch'

      failure_message _('Could not fetch roles')

      output do
        collection :ansible_roles, _('Ansible roles available to be imported') do
          field :name, _("Role Name")
          field :role_action, _("Action")
          field :variables, _("Variables")
          field :hosts_count, ("Hosts count")
          field :hostgroup_count, ("Hostgroup count")


        end
      end

      build_options
    end

    class PlayHostsCommand < HammerCLIForeman::Command
      resource :hosts
      action :multiple_play_roles
      command_name 'play-hosts'

      success_message _("Ansible roles are being played. Job ID: %{id}")
      failure_message _('Could not play roles on hosts')

      build_options
    end

    class PlayHostgroupsCommand < HammerCLIForeman::Command
      resource :hostgroups
      action :multiple_play_roles
      command_name 'play-hostgroups'

      success_message _("Ansible roles are being played. Job ID: %{id}")
      failure_message _('Could not play roles on hostgroups')

      build_options
    end

    autoload_subcommands
  end
end
