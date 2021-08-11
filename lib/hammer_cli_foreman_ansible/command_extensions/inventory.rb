# frozen_string_literal: true

module HammerCLIForemanAnsible
  module CommandExtensions
    class Inventory < HammerCLI::CommandExtensions
      output do |definition|
        definition.append do
          from 'foreman' do
            field :hostname, _('Name')
            field :fqdn, _('FQDN')
            field :hostgroup, _('Host Group')
            field :location, _('Location')
            field :organization, _('Organization')
            field :domainname, _('Domain')
            field :foreman_domain_description, _('Foreman domain description')
            field :owner_name, _('Owner name')
            field :owner_email, _('Owner email')
            field :ssh_authorized_keys, _('SSH authorized keys')
            field :root_pw, _('Root password')
            field :foreman_config_groups, _('Foreman config groups')
            field :puppetmaster, _('Puppet master')
            field :foreman_env, _('Puppet environment')

            collection :foreman_subnets, _('Subnets') do
              field :name, _('Name')
              field :network, _('Network')
              field :mask, _('Mask')
              field :gateway, _('Gateway')
              field :dns_primary, _('Primary DNS')
              field :dns_secondary, _('Secondary DNS')
              field :from, _('From')
              field :to, _('To')
              field :boot_mode, _('Boot mode')
              field :ipam, _('IPAM')
              field :vlanid, _('VLAN ID')
              field :mtu, _('MTU')
              field :nic_delay, _('NIC delay')
              field :network_type, _('Network type')
              field :description, _('Description')
            end

            collection :foreman_interfaces, _('Network interfaces') do
              field :name, _('Interface Name')
              field :identifier, _('Identifier')
              field :attrs,  _('Attributes'),Fields::Field, hide_blank: true
              field :mac, _('MAC address')
              field :ip, _('IPv4 address'), Fields::Field, hide_blank: true
              field :ip6, _('IPv6 address'), Fields::Field, hide_blank: true
              field :virtual, _('Virtual'), Fields::Boolean
              field :link, _('Link'), Fields::Boolean
              field :managed, _('Managed'), Fields::Boolean
              field :primary, _('Primary'), Fields::Boolean
              field :provision, _('Provision'), Fields::Boolean
              field :subnet6, _('IPv6 subnet')
              field :tag, _('Tag')
              field :attached_to, _('Attached to')
              field :type, _('Type')
              field :attached_devices, _('Attached devices')
              from 'subnet' do
                label _('Subnet'), hide_blank: true do
                  field :name, _('Name')
                  field :network, _('Network')
                  field :mask, _('Mask')
                  field :gateway, _('Gateway')
                  field :dns_primary, _('Primary DNS')
                  field :dns_secondary, _('Secondary DNS')
                  field :from, _('From')
                  field :to, _('To')
                  field :boot_mode, _('Boot mode')
                  field :ipam, _('IPAM')
                  field :vlanid, _('VLAN ID')
                  field :mtu, _('MTU')
                  field :nic_delay, _('NIC delay')
                  field :network_type, _('Network type')
                  field :description, _('Description')
                end
              end
            end

            collection :foreman_users, _('Foreman Users'), numbered: false do
              field :firstname, _('First name')
              field :lastname, _('Last name')
              field :mail, _('Email')
              field :description, _('Description')
              field :fullname, _('Full name')
              field :ssh_authorized_keys, _('SSH authorized keys')
            end
          end

          collection :foreman_ansible_roles, _('Foreman Ansible Roles'), numbered: false do
            field :name, _('Role')
          end

          field :ansible_roles_check_mode, _('Ansible role check mode'), Fields::Boolean
          field :host_packages, _('Host packages')
          field :host_registration_insights, _('Host registration insights'), Fields::Boolean
          field :host_registration_remote_execution, _('Host registration remote execution'), Fields::Boolean
          field :remote_execution_ssh_keys, _('Remote execution ssh keys')
          field :remote_execution_ssh_user, _('Remote execution ssh user')
          field :remote_execution_effective_user_method, _('Remote execution effective user method')
          field :remote_execution_connect_by_ip, _('Remote execution connect by IP'), Fields::Boolean
        end
      end

      before_print do |data, cmd_obj|
        unless cmd_obj.option_as_json?
          new_data = data['all']['hosts'].each_with_object([]) do |hostname, arr|
            data['_meta']['hostvars'][hostname]['foreman']['foreman_users'] = data['_meta']['hostvars'][hostname]['foreman']['foreman_users']&.map { |u| u[1] }
            data['_meta']['hostvars'][hostname]['foreman_ansible_roles'] =  data['_meta']['hostvars'][hostname]['foreman_ansible_roles']&.map { |r| { 'name' => r } }
            arr << {
              'hostname' => hostname
            }.merge(data['_meta']['hostvars'][hostname])
          end
          data.clear
          data['results'] = new_data
        end
      end
    end
  end
end
