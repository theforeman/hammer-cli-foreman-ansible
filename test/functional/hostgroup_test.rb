require File.join(File.dirname(__FILE__), 'test_helper')

describe 'hostgroup' do
  describe 'add ansible role' do
    let(:cmd) { %w[hostgroup ansible-roles add] }
    let(:ansible_role_1) do
      {
        'id': 1,
        'name': 'role1'
      }
    end

    it 'requires hostgroup --id' do
      expected_result = usage_error_result(
        cmd,
        'At least one of options --name, --title, --id is required.',
        'Could not associate the Ansible role'
      )

      api_expects_no_call

      result = run_cmd(cmd)
      assert_cmd(expected_result, result)
    end

    it 'requires hostgroup id and asnible role id' do
      params = %w[--id=1]
      expected_result = usage_error_result(
        cmd,
        'At least one of options --ansible-role, --ansible-role-id is required.',
        'Could not associate the Ansible role'
      )

      api_expects_no_call

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end

    it 'associates ansible role with hostgroup' do
      params = %w[--id=1 --ansible-role-id=2]

      api_expects(:hostgroups, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns([ansible_role_1])

      api_expects(:hostgroups, :update) do |par|
        par['id'] == '1' &&
          par['hostgroup']['ansible_role_ids'] == %w[1 2]
      end

      result = run_cmd(cmd + params)
      assert_cmd(success_result("Ansible role has been associated.\n"), result)
    end
  end

  describe 'remove ansible role' do
    let(:cmd) { %w[hostgroup ansible-roles remove] }
    let(:ansible_roles) do
      [
        {
          'id': 1,
          'name': 'role1'
        },
        {
          'id': 2,
          'name': 'role2'
        }
      ]
    end

    it 'requires hostgroup --id' do
      expected_result = usage_error_result(
        cmd,
        'At least one of options --name, --title, --id is required.',
        'Could not disassociate the Ansible role'
      )

      api_expects_no_call

      result = run_cmd(cmd)
      assert_cmd(expected_result, result)
    end

    it 'requires hostgroup id and asnible role id' do
      params = %w[--id=1]
      expected_result = usage_error_result(
        cmd,
        'At least one of options --ansible-role, --ansible-role-id is required.',
        'Could not disassociate the Ansible role'
      )

      api_expects_no_call

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end

    it 'disassociates ansible role from hostgroup' do
      params = %w[--id=1 --ansible-role-id=2]

      api_expects(:hostgroups, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns(ansible_roles)

      api_expects(:hostgroups, :update) do |par|
        par['id'] == '1' &&
          par['hostgroup']['ansible_role_ids'] == %w[1]
      end

      result = run_cmd(cmd + params)
      assert_cmd(success_result("Ansible role has been disassociated.\n"), result)
    end
  end
end
