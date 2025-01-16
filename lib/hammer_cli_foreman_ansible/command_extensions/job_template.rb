# frozen_string_literal: true

module HammerCLIForemanAnsible
  module CommandExtensions
    class JobTemplate < HammerCLI::CommandExtensions
      before_print do |data|
        unless data['provider_type'] == 'Ansible'
          data.delete('ansible_callback_enabled')
          data.delete('ansible_check_mode')
        end
      end

      output do |definition|
        definition.insert(:before, :description) do
          field :ansible_callback_enabled, _('Ansible Callback Enabled'), Fields::Boolean
          field :ansible_check_mode, _('Ansible Check Mode Enabled'), Fields::Boolean
        end
      end
    end
  end
end
