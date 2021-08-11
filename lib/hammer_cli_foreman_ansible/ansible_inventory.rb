# frozen_string_literal: true

module HammerCLIForemanAnsible
  class AnsibleInventoryCommand < HammerCLIForeman::Command
    resource :ansible_inventories

    class HostsCommand < HammerCLIForeman::Command
      action :hosts
      command_name 'hosts'
      option '--as-json', :flag, _('Full response as json')

      def print_data(data)
        return super unless option_as_json?

        puts JSON.pretty_generate(data)
      end
      build_options

      extend_with(HammerCLIForemanAnsible::CommandExtensions::Inventory.new)
    end

    class HostgroupsCommand < HammerCLIForeman::Command
      action :hostgroups
      command_name 'hostgroups'
      option '--as-json', :flag, _('Full response as json')

      def print_data(data)
        return super unless option_as_json?

        puts JSON.pretty_generate(data)
      end
      build_options

      extend_with(HammerCLIForemanAnsible::CommandExtensions::Inventory.new)
    end

    class ScheduleCommand < HammerCLIForeman::Command
      action :schedule
      command_name 'schedule'

      output do
        field :job_id, _('Job Id')
        field :data_url, _('Data URL')
      end

      build_options
    end

    autoload_subcommands
  end
end

