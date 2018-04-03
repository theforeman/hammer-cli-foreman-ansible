module HammerCLIForemanAnsible
  class AnsibleRolesCommand < HammerCLIForeman::Command
    resource :ansible_roles

    class InfoCommand < HammerCLIForeman::InfoCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
        field :created_at, _('Imported at')
      end
      build_options
    end

    class ListCommand < HammerCLIForeman::ListCommand
      output HammerCLIForemanAnsible::AnsibleRolesCommand::InfoCommand.output_definition
      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Ansible role [%{name}] was deleted.')
      failure_message _('Could not delete the role')

      build_options
    end

    class ImportCommand < HammerCLIForeman::Command
      action :import
      command_name 'import'

      failure_message _('Could not import the new roles')

      def print_data(data)
        if data.empty?
          puts 'No changes in ansible roles detected.'
          return
        end
        puts 'The following new ansible roles were imported:'
        data.each do |role|
          puts role['name']
        end
      end

      build_options
    end

    class ObsoleteCommand < HammerCLIForeman::Command
      action :obsolete
      command_name 'obsolete'

      failure_message _('Could not import the obsolete roles')

      def print_data(data)
        if data.empty?
          puts 'No changes in ansible roles detected.'
          return
        end
        puts 'The following obsolete ansible roles were imported:'
        data.each do |role|
          puts role['name']
        end
      end

      build_options
    end

    autoload_subcommands
  end
end
