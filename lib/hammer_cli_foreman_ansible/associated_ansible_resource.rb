module HammerCLIForemanAnsible
  module AssociatedAnsibleResource
    def get_current_ids
      resources = HammerCLIForeman.record_to_common_format(resource.call(association_name(true), { id: get_identifier }))
      resources.map do |resource|
        next resource['id'] unless self.class.command_names.include?('remove')

        if resource['inherited'] && resource['id'] == option_ansible_role_id
          raise ArgumentError, _('Ansible role %s is inherited and cannot be removed.') % resource['name']
        end

        resource['id']
      end
    end
  end
end
