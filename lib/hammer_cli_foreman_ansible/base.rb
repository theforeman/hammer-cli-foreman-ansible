module HammerCLIForemanAnsible
  class BaseAnsibleRolesCommand < HammerCLIForeman::Command
    command_name 'ansible-roles'
    desc _('List all Ansible roles')

    action :ansible_roles

    output do
      field :id, _('Id')
      field :name, _('Name')
      field :created_at, _('Imported at'), Fields::Date
    end

    def adapter
      :table
    end
  end

  class BaseAnsibleVariablesCommand < HammerCLIForeman::Command
    command_name 'ansible-variables'
    desc _('List all Ansible variables')

    action :ansible_variables

    output do
      field :id, _('Id')

      field :variable, _('Variable')
      field :default_value, _('Default Value')
      field :variable_type, _('Type')

      field :ansible_role, _('Role')
      field :ansible_role_id, _('Role Id'), Fields::Id
    end

    def adapter
      :table
    end
  end
end
