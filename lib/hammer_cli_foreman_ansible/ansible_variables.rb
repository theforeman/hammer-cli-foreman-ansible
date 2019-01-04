module HammerCLIForemanAnsible
  class AnsibleVariablesCommand < HammerCLIForeman::Command
    resource :ansible_variables

    class ListCommand < HammerCLIForeman::ListCommand
      output BaseAnsibleVariablesCommand.output_definition
      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output AnsibleVariablesCommand::ListCommand.output_definition do
        field :description, _("Description")
        field :hidden_value?, _("Hidden Value?"), Fields::Boolean

        label _("Validator") do
          field :validator_type, _("Type")
          field :validator_rule, _("Rule")
        end
        label _("Override values") do
          field :merge_overrides, _("Merge overrides"), Fields::Boolean
          field :merge_default, _("Merge default value"), Fields::Boolean
          field :avoid_duplicates, _("Avoid duplicates"), Fields::Boolean
          field :override_value_order, _("Order"), Fields::LongText
          collection :override_values, _("Values") do
            field :id, _('Id')
            field :match, _('Match')
            field :value, _('Value')
          end
        end

        HammerCLIForeman::References.timestamps(self)
      end
      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Ansible variable [%{variable}] was deleted.')
      failure_message _('Could not delete the variable')

      build_options
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _("Ansible variable [%{variable}] updated.")
      failure_message _("Could not update the ansible variable")

      build_options
    end

    class ChangedCommand < HammerCLIForeman::Command
      def execute
        response = {}
        response['changed'] = send_request
        response['message'] = _('The following ansible variables were changed')
        if response['changed'].empty?
          response['message'] = _('No changes in ansible variables detected.')
        end
        print_data(response)
        HammerCLI::EX_OK
      end
    end

    class ImportCommand < ChangedCommand
      action :import
      command_name 'import'

      failure_message _('Could not import variables')

      output do
        field :message, _('Result'), Fields::LongText
        collection :changed, _('Imported'), hide_blank: true do
          field :variable, nil
        end
      end

      build_options
    end

    class ObsoleteCommand < ChangedCommand
      action :obsolete
      command_name 'obsolete'

      failure_message _('Could not obsolete variables')

      output do
        field :message, _('Result'), Fields::LongText
        collection :changed, _('Obsoleted'), hide_blank: true do
          field :variable, nil
        end
      end

      build_options
    end

    class AddMatcherCommand < HammerCLIForeman::CreateCommand
      resource :ansible_override_values
      command_name 'add-matcher'

      option '--value', 'VALUE', _('Override value, required if omit is false')

      success_message _("Override value created.")
      failure_message _("Could not create the override value")

      build_options
    end

    class RemoveMatcherCommand < HammerCLIForeman::DeleteCommand
      resource :ansible_override_values
      command_name 'remove-matcher'

      success_message _("Override value deleted.")
      failure_message _("Could not delete the override value")

      build_options
    end

    autoload_subcommands
  end
end
