module HammerCLIForemanAnsible
  class BaseAnsibleRolesCommand < HammerCLIForeman::Command
    command_name 'ansible-roles'
    desc _('List all Ansible roles')

    action :ansible_roles

    output do
      field :id, _('Id'), Fields::Id
      field :name, _('Name')
      field :created_at, _('Imported at'), Fields::Date
    end

    def adapter
      :table
    end
  end
end
