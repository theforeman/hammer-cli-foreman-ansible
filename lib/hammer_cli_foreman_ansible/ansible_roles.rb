module HammerCLIForemanAnsible
  class AnsibleRolesCommand < HammerCLIForeman::Command
    resource :ansible_roles

    class InfoCommand < HammerCLIForeman::InfoCommand
      output BaseAnsibleRolesCommand.output_definition
      build_options
    end

    class ListCommand < HammerCLIForeman::ListCommand
      output AnsibleRolesCommand::InfoCommand.output_definition
      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Ansible role [%{name}] was deleted.')
      failure_message _('Could not delete the role')

      build_options
    end

    class ChangedCommand < HammerCLIForeman::Command
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
    end

    class ImportCommand < ChangedCommand
      action :import
      command_name 'import'

      failure_message _('Could not import roles')

      output do
        field :message, _('Result'), Fields::LongText
        collection :changed, _('Imported'), hide_blank: true do
          field :name, nil
        end
      end

      build_options
    end

    class ObsoleteCommand < ChangedCommand
      action :obsolete
      command_name 'obsolete'

      failure_message _('Could not obsolete roles')

      output do
        field :message, _('Result'), Fields::LongText
        collection :changed, _('Obsoleted'), hide_blank: true do
          field :name, nil
        end
      end

      build_options
    end

    autoload_subcommands
  end
end
