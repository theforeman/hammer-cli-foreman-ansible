# frozen_string_literal: true

module HammerCLIForemanAnsible
  module CommandExtensions
    class JobTemplate < HammerCLI::CommandExtensions
      before_print do |data|
        unless data['provider_type'] == 'Ansible'
          data.delete('ansible_callback_enabled')
        end
      end

      output do |definition|
        definition.insert(:before, :description) do
          field :ansible_callback_enabled, _('Ansible Callback Enabled'), Fields::Boolean
        end
      end
    end
  end
end
