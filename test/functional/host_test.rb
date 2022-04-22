require File.join(File.dirname(__FILE__), 'test_helper')

describe 'host' do
  let(:ansible_role_1) do
    {
      'id' => 1,
      'name' => 'role1',
      'inherited' => false,
      'directly_assigned' => true
    }
  end
  let(:ansible_role_2) do
    {
      'id' => 2,
      'name' => 'role2',
      'inherited' => true,
      'directly_assigned' => false
    }
  end
  let(:ansible_roles) do
    [
      ansible_role_1,
      ansible_role_2
    ]
  end

  describe 'add ansible role' do
    let(:cmd) { %w[host ansible-roles add] }

    it 'requires host --id' do
      expected_result = usage_error_result(
        cmd,
        'At least one of options --name, --id is required.',
        'Could not associate the Ansible role'
      )

      api_expects_no_call

      result = run_cmd(cmd)
      assert_cmd(expected_result, result)
    end

    it 'requires host id and asnible role id' do
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

    it 'associates ansible role with host' do
      params = %w[--id=1 --ansible-role-id=2]

      api_expects(:hosts, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns([ansible_role_1])

      api_expects(:hosts, :update) do |par|
        par['id'] == '1' &&
          par['host']['ansible_role_ids'] == %w[1 2]
      end

      result = run_cmd(cmd + params)
      assert_cmd(success_result("Ansible role has been associated.\n"), result)
    end

    it 'raises an error on associating an inherited ansible role to host' do
      params = %w[--id=1 --ansible-role-id=2]
      expected_result = CommandExpectation.new
      expected_result.expected_err = [
        'Could not associate the Ansible role:',
        '  Ansible role role2 is already inherited from a host group. Please use --force for direct association.',
        ''
      ].join("\n")
      expected_result.expected_exit_code = HammerCLI::EX_USAGE

      api_expects(:hosts, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns(ansible_roles)

      api_expects_no_call

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end

    it 'associates inherited ansible role with host' do
      params = %w[--id=1 --ansible-role-id=2 --force]

      api_expects(:hosts, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns(ansible_roles)

      api_expects(:hosts, :update) do |par|
        par['id'] == '1' &&
          par['host']['ansible_role_ids'] == %w[1 2]
      end

      result = run_cmd(cmd + params)
      assert_cmd(success_result("Ansible role has been associated.\n"), result)
    end
  end

  describe 'remove ansible role' do
    let(:cmd) { %w[host ansible-roles remove] }

    it 'requires host --id' do
      expected_result = usage_error_result(
        cmd,
        'At least one of options --name, --id is required.',
        'Could not disassociate the Ansible role'
      )

      api_expects_no_call

      result = run_cmd(cmd)
      assert_cmd(expected_result, result)
    end

    it 'requires host id and asnible role id' do
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

    it 'disassociates ansible role from host' do
      params = %w[--id=1 --ansible-role-id=1]

      api_expects(:hosts, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns(ansible_roles)

      api_expects(:hosts, :update) do |par|
        par['id'] == '1' &&
          par['host']['ansible_role_ids'] == %w[]
      end

      result = run_cmd(cmd + params)
      assert_cmd(success_result("Ansible role has been disassociated.\n"), result)
    end

    it 'raises an error on disassociating an inherited ansible role from host by id' do
      params = %w[--id=1 --ansible-role-id=2]
      expected_result = CommandExpectation.new
      expected_result.expected_err = [
        'Could not disassociate the Ansible role:',
        '  Ansible role role2 is not assigned directly and cannot be removed.',
        ''
      ].join("\n")
      expected_result.expected_exit_code = HammerCLI::EX_USAGE

      api_expects(:hosts, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns(ansible_roles)

      api_expects_no_call

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end

    it 'raises an error on disassociating an inherited ansible role from host by name' do
      params = %w[--id=1 --ansible-role=role2]
      expected_result = CommandExpectation.new
      expected_result.expected_err = [
        'Could not disassociate the Ansible role:',
        '  Ansible role role2 is not assigned directly and cannot be removed.',
        ''
      ].join("\n")
      expected_result.expected_exit_code = HammerCLI::EX_USAGE

      api_expects(:ansible_roles, :index) do |par|
        par[:search] == 'name = "role2"'
      end.returns(ansible_role_2)

      api_expects(:hosts, :ansible_roles) do |par|
        par[:id] == '1'
      end.returns(ansible_roles)

      api_expects_no_call

      result = run_cmd(cmd + params)
      assert_cmd(expected_result, result)
    end
  end
end
