module HammerCLIForemanAnsible
  module AssociatedAnsibleRole
    # This method fetches all associated resource (ansible roles) ids
    # to send them back via :update endpoint of the main resource (host/hostgroup)
    # We use this array of ids to add or remove direct associations
    # This method is used to 'reset' associated ids via HammerCLIForeman::[Add|Remove]AssociatedCommand
    def get_current_ids
      roles = HammerCLIForeman.record_to_common_format(resource.call(association_name(true), { id: get_identifier }))
      return ids_to_keep_for_removal(roles) if self.class.command_names.include?('remove')

      ids_to_keep_for_addition(roles)
    end

    private

    # Treat inherited as we do in UI:
    # - Don't allow to directly associate them (the role is not available to select)
    # - If the same role was assigned AND inherited then treat it as it was just assigned (keep it)
    # - If the role is indirectly associated only then don't associate it directly unless --force provided
    def ids_to_keep_for_addition(roles)
      roles.map do |role|
        # Keep directly associated roles
        next role['id'] if role['owned']

        # Host groups can have not inherited and not owned roles in the response.
        # This means those roles are from hosts, skip them.
        # Hosts cannot have such case.

        # Pre-check to force stop the command if we're trying to add an already inherited role
        # (in case we don't have it directly associated as well)
        if option_ansible_role_id == role['id'] && role['inherited']
          next role['id'] if option_force?

          msg = _(
            'Ansible role %{name} is already inherited from a host group. Please use %{option} for direct association.'
          ) % { name: role['name'], option: '--force' }
          raise ArgumentError, msg
        end

        # We skip not owned and inherited
        # Also skip not inherited for host groups
        nil
      end.compact
    end

    # Treat inherited as we do in UI:
    # - Don't allow to remove them (the role is not available to select)
    # - If the same role was assigned AND inherited then treat it as it was just assigned (keep or remove it)
    # - If the role was inherited only then don't remove it
    def ids_to_keep_for_removal(roles)
      roles.map do |role|
        # Keep or remove later directly associated roles
        next role['id'] if role['owned']

        # Pre-check to force stop the command if we're trying to remove not owned role
        if role['id'] == option_ansible_role_id
          raise ArgumentError, _('Ansible role %s is not assigned directly and cannot be removed.') % role['name']
        end

        # We skip not owned and inherited
        # Also skip not inherited for host groups
        nil
      end.compact
    end
  end
end
